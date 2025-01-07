module 0xae52b0e99c0c35291fba99aeab694b4f88a6a88aa5b4405d5698e4fb8bd180c0::sagmi {
    struct SAGMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAGMI>(arg0, 6, b"SAGMI", b"SUI ALL GUNNA MAKE IT", b"WAGMI ON SUI IS $SAGMI OG WOJAK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3643_5cda0178d2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAGMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAGMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

