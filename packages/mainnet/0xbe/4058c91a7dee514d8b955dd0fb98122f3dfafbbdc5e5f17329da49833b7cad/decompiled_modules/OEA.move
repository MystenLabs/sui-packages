module 0xbe4058c91a7dee514d8b955dd0fb98122f3dfafbbdc5e5f17329da49833b7cad::OEA {
    struct OEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OEA>(arg0, 6, b"OEA", b"oo ee aa ee", b"everybody's favourite crashout cat spinning into another dimension", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmUSkCdtWR4jxH1mZM1ZGUVgzpUYUYX8Zv3Yh97KtQmebN")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OEA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OEA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

