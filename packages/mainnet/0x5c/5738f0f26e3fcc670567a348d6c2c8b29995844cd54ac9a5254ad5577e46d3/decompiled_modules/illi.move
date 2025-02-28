module 0x5c5738f0f26e3fcc670567a348d6c2c8b29995844cd54ac9a5254ad5577e46d3::illi {
    struct ILLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ILLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ILLI>(arg0, 9, b"ILLI", b"Illi Token", b"A new token on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ILLI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ILLI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ILLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

