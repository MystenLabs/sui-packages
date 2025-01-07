module 0x6c90582f677568796467efea0a8284e90c31d11c990c78d27c374b39ab4512dd::ZOO {
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

