module 0x904fa8092a66ca4610a2033773dcda3eebdd657d9858b6d74cd3b2e4d13122ad::edog {
    struct EDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDOG>(arg0, 6, b"EDOG", b"EDOGSUI", x"45444f475355492047657420726561647920746f206261726b207570205355492020697473207061772d736f6d652c2069747320636c61737369632c20697473202445444f47210a4f637420313074682020676f696e6720646f776e206f6e200a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x5e975e7f36f2658d4cf146142899c659464a3e0d90f0f4d5f8b2447173c06ef6_edog_edog_55e1fb6af4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

