module 0xbaf6140dd6c673a70744fa027c1b76cd2967fa7f3f86c28332be80dd042529a2::hope {
    struct HOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPE>(arg0, 9, b"HOPE", b"HOPE CTO", b"https://hopecto.xyz/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://framerusercontent.com/images/ZMa31KGwkilR94NUPonBtDzfws.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOPE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

