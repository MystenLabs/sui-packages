module 0x3f7e0e34d771c29c562438254f570a43f607cbcb2b21d7a2b31b84d46f2ed269::sscat {
    struct SSCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSCAT>(arg0, 6, b"SSCAT", b"Gizmo The Cat", x"54524141414141414149545320415245204f4e4c494e45454545454545452121212054484520494e444558494e4720495453205354494c4c20474f494e47205748494c4520544845204341545320415245205354494c4c20494e20544845204d454d504f4f4c2120200a0a59555555555555555252525252520a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bed7e341aef20d02d24a5544e5cc801ac05bae6c2cfd9418865d7a869f193643i0_e63755611a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

