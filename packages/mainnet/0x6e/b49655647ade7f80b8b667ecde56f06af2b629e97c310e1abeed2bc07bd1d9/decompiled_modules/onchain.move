module 0x6eb49655647ade7f80b8b667ecde56f06af2b629e97c310e1abeed2bc07bd1d9::onchain {
    struct ONCHAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONCHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONCHAIN>(arg0, 6, b"ONCHAIN", b"ONCHAIN SUI", x"244f4e434841494e20697320696e74726f647563696e672074686520536c6f7764726f70206d656368616e69736d2c20776865726520746f6b656e732077696c6c206265206469737472696275746564207468726f756768206120636f6d7065746974696f6e2c206261736564206f6e2061206361726566756c20636f6e74696e756f757320617070726f6163682c20706f77657265642062792046617263617374657220616e64204775696c642e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_Zsk74_X4_400x400_a93b1bf5de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONCHAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONCHAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

