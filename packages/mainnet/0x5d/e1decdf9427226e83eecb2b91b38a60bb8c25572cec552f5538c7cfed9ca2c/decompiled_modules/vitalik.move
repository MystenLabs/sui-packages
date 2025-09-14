module 0x5de1decdf9427226e83eecb2b91b38a60bb8c25572cec552f5538c7cfed9ca2c::vitalik {
    struct VITALIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: VITALIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VITALIK>(arg0, 9, b"Vitalik on SUI", b"VITALIK", b"Dance to the moon | Website: https://x.com/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/13ZkgsI.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VITALIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VITALIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

