module 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::metadata_integrity {
    struct Integrity has drop, store {
        integrity: vector<u8>,
    }

    struct IntegrityDfKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun borrow(arg0: &0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::file::File) : &vector<u8> {
        let v0 = IntegrityDfKey{dummy_field: false};
        &0x2::dynamic_field::borrow<IntegrityDfKey, Integrity>(0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::file::uid(arg0), v0).integrity
    }

    public fun has(arg0: &0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::file::File) : bool {
        let v0 = IntegrityDfKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<IntegrityDfKey, Integrity>(0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::file::uid(arg0), v0)
    }

    public fun set(arg0: &mut 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::file::File, arg1: vector<u8>) {
        let v0 = 0x1f74bb1f1008a8062c5ec8636a7d6a863d39167f48bf6a80cdab805aaca8511d::file::uid_mut(arg0);
        let v1 = IntegrityDfKey{dummy_field: false};
        0x2::dynamic_field::remove_if_exists<IntegrityDfKey, Integrity>(v0, v1);
        let v2 = IntegrityDfKey{dummy_field: false};
        let v3 = Integrity{integrity: arg1};
        0x2::dynamic_field::add<IntegrityDfKey, Integrity>(v0, v2, v3);
    }

    // decompiled from Move bytecode v6
}

