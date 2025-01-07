module 0x83e4a80f3f13a60d84401762a8802ce5575e117367a50685e710650eb34c880e::syria {
    struct SYRIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYRIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYRIA>(arg0, 9, b"syria", b"syria", b"aleppo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SYRIA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYRIA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYRIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

