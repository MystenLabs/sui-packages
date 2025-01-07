module 0x2b03501fe66fbf9e8f5eb787e373291b89566867d2d3b9b6ee87ceec4b770ebb::fcat {
    struct FCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCAT>(arg0, 6, b"Fcat", b"FishCat", b"A kitten came with a fish in its mouth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730999331494.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

