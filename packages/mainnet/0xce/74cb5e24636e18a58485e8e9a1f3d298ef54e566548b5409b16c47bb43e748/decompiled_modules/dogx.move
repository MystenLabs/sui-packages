module 0xce74cb5e24636e18a58485e8e9a1f3d298ef54e566548b5409b16c47bb43e748::dogx {
    struct DOGX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGX>(arg0, 6, b"DOGX", b"DogX", x"45766572796f6e65206c6f766520444f47580a546865206e61746976652058206d656d6520636f696e0a41697264726f7020666f722074686520584f472120436c61696d20446f67582068747470733a2f2f742e6d652f5265616c446f67585f426f743f73746172743d5456396d61566f516b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9735_9aa0e8567d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGX>>(v1);
    }

    // decompiled from Move bytecode v6
}

