module 0xc73e79d99ca2cf5872cb2c01d737b536e93d15e16f9e373a3a5af742240c4389::ZOO {
    struct ZOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOO>(arg0, 9, b"ZOO", b"ZOO", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZOO>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ZOO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<ZOO>>(0x2::coin::mint<ZOO>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

