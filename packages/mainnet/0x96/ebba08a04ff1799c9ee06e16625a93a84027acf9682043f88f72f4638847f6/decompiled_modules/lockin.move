module 0x96ebba08a04ff1799c9ee06e16625a93a84027acf9682043f88f72f4638847f6::lockin {
    struct LOCKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOCKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOCKIN>(arg0, 6, b"LOCKIN", b"Lock in", b"you gotta lock in lil bro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1235_5d162dbf70.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOCKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOCKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

