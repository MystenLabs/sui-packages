module 0xcc0a38d0182dcbfb3482f22cd12903364cdf73f8bfe317fdf065e242bb865519::volt {
    struct VOLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOLT>(arg0, 9, b"VOLT", b"VOLT.WIN", b"Built on TitanX. You ready to open the VOLT?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x66b5228cfd34d9f4d9f03188d67816286c7c0b74.png?size=lg&key=f60fd2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VOLT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOLT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VOLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

