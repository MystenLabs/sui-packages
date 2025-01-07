module 0xc10fffd09cb1b67ec56e109fadd1dbddd9d094f2bcc35fef5243d6b026e49ec1::stot {
    struct STOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STOT>(arg0, 6, b"STOT", b"SuiTOT", b"WE ITOT ON SUI NETWORK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ITOT_1fff6d1fb8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

