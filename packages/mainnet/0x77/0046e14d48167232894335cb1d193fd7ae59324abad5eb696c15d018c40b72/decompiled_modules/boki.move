module 0x770046e14d48167232894335cb1d193fd7ae59324abad5eb696c15d018c40b72::boki {
    struct BOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOKI>(arg0, 6, b"BOKI", b"Book Of Kitty", b"Book of Kitty is built on top of SUIs strong blockchain, which is safe, expandable, and user-friendly.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/noname_0e1298ce41_c48e72dfbe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

