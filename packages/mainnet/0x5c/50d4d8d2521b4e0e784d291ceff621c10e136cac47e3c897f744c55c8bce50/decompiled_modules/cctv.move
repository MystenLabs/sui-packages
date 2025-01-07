module 0x5c50d4d8d2521b4e0e784d291ceff621c10e136cac47e3c897f744c55c8bce50::cctv {
    struct CCTV has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCTV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCTV>(arg0, 6, b"CCTV", b"Suisuitv", b"BILLIONS MUST WATCH $CCTV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Camera_Logo_35f0e43ecf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCTV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCTV>>(v1);
    }

    // decompiled from Move bytecode v6
}

