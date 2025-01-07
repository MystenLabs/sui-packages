module 0x45034e2f219ddcfb72da453f050e84e0d37fe6a21660e43f46082723189392f::dorkl {
    struct DORKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORKL>(arg0, 6, b"DORKL", b"Dork Lord On SUI", x"446f726b204c6f7264204973204865726520546f0a446f6d696e617465205355492e0a0a466f6c6c6f772068696d2c20616e64206761696e2e200a0a466164652068696d2c20616e64207065726973682e0a0a5072657061726520796f75720a737068696e637465722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_16_43_28_fb831e23f2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

