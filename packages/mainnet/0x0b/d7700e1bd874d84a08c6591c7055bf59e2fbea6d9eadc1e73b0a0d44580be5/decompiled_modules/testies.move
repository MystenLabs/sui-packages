module 0xbd7700e1bd874d84a08c6591c7055bf59e2fbea6d9eadc1e73b0a0d44580be5::testies {
    struct TESTIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTIES>(arg0, 6, b"TESTIES", b"TESTicles", b"testie balls bollocks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_12_01_at_22_06_59_d3626240e4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

