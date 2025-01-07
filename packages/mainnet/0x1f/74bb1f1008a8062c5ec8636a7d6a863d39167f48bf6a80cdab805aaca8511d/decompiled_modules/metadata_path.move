module 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::metadata_path {
    struct Path has drop, store {
        path: 0x1::string::String,
    }

    struct PathDfKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun borrow(arg0: &0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::file::File) : &0x1::string::String {
        let v0 = PathDfKey{dummy_field: false};
        &0x2::dynamic_field::borrow<PathDfKey, Path>(0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::file::uid(arg0), v0).path
    }

    public fun has(arg0: &0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::file::File) : bool {
        let v0 = PathDfKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<PathDfKey, Path>(0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::file::uid(arg0), v0)
    }

    public fun set(arg0: &mut 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::file::File, arg1: 0x1::string::String) {
        let v0 = 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::file::uid_mut(arg0);
        let v1 = PathDfKey{dummy_field: false};
        0x2::dynamic_field::remove_if_exists<PathDfKey, Path>(v0, v1);
        let v2 = PathDfKey{dummy_field: false};
        let v3 = Path{path: arg1};
        0x2::dynamic_field::add<PathDfKey, Path>(v0, v2, v3);
    }

    // decompiled from Move bytecode v6
}

