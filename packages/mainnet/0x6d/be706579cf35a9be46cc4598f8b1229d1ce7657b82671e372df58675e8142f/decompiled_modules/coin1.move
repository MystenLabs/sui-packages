module 0x6dbe706579cf35a9be46cc4598f8b1229d1ce7657b82671e372df58675e8142f::coin1 {
    struct COIN1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COIN1>(arg0, 9, b"TICKER1", b"coin1", b"desc1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://localhost:9000/kappa/kappa/coins/3a7da86e-7e24-4826-98c0-a3dea868bf42.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COIN1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

