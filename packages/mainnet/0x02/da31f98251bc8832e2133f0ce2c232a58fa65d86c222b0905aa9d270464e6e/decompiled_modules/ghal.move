module 0x2da31f98251bc8832e2133f0ce2c232a58fa65d86c222b0905aa9d270464e6e::ghal {
    struct GHAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHAL>(arg0, 6, b"GHAL", b"Ghost Halloween", b"Ghost Halloween is live now on Turbo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730978432601.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

