module 0xa3d09a2bb44af31d01e7cb571c6abcdd89c66e6b51bf1493f000eb137d1d035b::orbit {
    struct ORBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORBIT>(arg0, 6, b"ORBIT", b"OrbitAI", x"4f72626974616c20656d706f7765727320757365727320746f206465706c6f79206175746f6e6f6d6f757320416c204167656e7473207769746820756e6d617463686564207072697661637920616e6420636f6e74726f6c2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1740016415314.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORBIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORBIT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

