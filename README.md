# writeEXIF

An R script that generates placeholder JPEG images and writes GPS coordinates and dates into their EXIF metadata using [ExifTool](https://exiftool.org/).

## What it does

`node_exif.R` reads node data from two CSV files and, for each node, produces a labeled JPEG whose EXIF tags carry the node's geographic location and timestamp. This is useful for creating geotagged sample images keyed by a node identifier.

For every row in the location file the script:

1. Creates a blank JPEG in `./nodejpg/`, named after the node ID (column 4), with the node ID rendered as a centered label.
2. Writes GPS latitude/longitude into the image's EXIF metadata (`-GPSLatitude`, `-GPSLongitude`, with `N`/`E` reference directions).
3. Writes the date/time: if a matching node ID is found in the date file, all date tags (`-alldates`) are set to that node's timestamp; otherwise they default to the current time (`now`).
4. Cleans up ExifTool's `*_original` backup files at the end.

## Input files

| File | Description | Columns used |
| --- | --- | --- |
| `latlon_exif.csv` | One row per node with coordinates | 4 = node ID, 10 = latitude, 11 = longitude |
| `date_exif.csv` | Node timestamps (optional per node) | 4 = node ID, 8 = date/time |

## Output

Geotagged JPEG files written to `./nodejpg/`, one per node, named `<node_id>.jpg`.

## Requirements

- [R](https://www.r-project.org/)
- [ExifTool](https://exiftool.org/) available on the system `PATH`

## Usage

```sh
Rscript node_exif.R
```

Make sure `latlon_exif.csv` and `date_exif.csv` are in the working directory and that the `./nodejpg/` directory exists before running.
