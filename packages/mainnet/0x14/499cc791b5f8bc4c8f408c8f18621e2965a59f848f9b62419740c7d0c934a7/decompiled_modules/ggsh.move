module 0x14499cc791b5f8bc4c8f408c8f18621e2965a59f848f9b62419740c7d0c934a7::ggsh {
    struct GGSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GGSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GGSH>(arg0, 9, b"ggsh", b"ggshawcoin", b"Happy fathers day!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgur.com/a/dad1-pqFSmMf")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GGSH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GGSH>>(v2, @0x3b49faa9cc82c6cf84c956918f4f8381df29213c4cbef682d30ef333b7e89008);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GGSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

