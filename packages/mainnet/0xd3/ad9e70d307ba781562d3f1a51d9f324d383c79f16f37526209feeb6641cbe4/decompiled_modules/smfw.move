module 0xd3ad9e70d307ba781562d3f1a51d9f324d383c79f16f37526209feeb6641cbe4::smfw {
    struct SMFW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMFW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMFW>(arg0, 6, b"SMFW", b"FUCK MAN ZHENGYI", b"WOSHIZHENGYI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240925183226_b9b75533e3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMFW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMFW>>(v1);
    }

    // decompiled from Move bytecode v6
}

