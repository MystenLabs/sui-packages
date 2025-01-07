module 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::metadata_content {
    struct Content has drop, store {
        type: 0x1::string::String,
        encoding: 0x1::string::String,
    }

    struct ContentDfKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun borrow(arg0: &0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::file::File) : &Content {
        let v0 = ContentDfKey{dummy_field: false};
        0x2::dynamic_field::borrow<ContentDfKey, Content>(0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::file::uid(arg0), v0)
    }

    public fun encoding(arg0: &Content) : &0x1::string::String {
        &arg0.encoding
    }

    public fun has(arg0: &0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::file::File) : bool {
        let v0 = ContentDfKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<ContentDfKey, Content>(0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::file::uid(arg0), v0)
    }

    public fun set(arg0: &mut 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::file::File, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        let v0 = 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::file::uid_mut(arg0);
        let v1 = ContentDfKey{dummy_field: false};
        0x2::dynamic_field::remove_if_exists<ContentDfKey, Content>(v0, v1);
        let v2 = ContentDfKey{dummy_field: false};
        let v3 = Content{
            type     : arg1,
            encoding : arg2,
        };
        0x2::dynamic_field::add<ContentDfKey, Content>(v0, v2, v3);
    }

    public fun type(arg0: &Content) : &0x1::string::String {
        &arg0.type
    }

    // decompiled from Move bytecode v6
}

