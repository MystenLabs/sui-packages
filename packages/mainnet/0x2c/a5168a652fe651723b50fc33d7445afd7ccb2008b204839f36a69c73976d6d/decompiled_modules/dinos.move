module 0x2ca5168a652fe651723b50fc33d7445afd7ccb2008b204839f36a69c73976d6d::dinos {
    struct DINOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINOS>(arg0, 6, b"DINOS", b"DinoSuir", x"44696e6f537569722c20746865206669727374207072652d686973746f7269632072657074696c652062726f75676874206261636b20746f206c696665206f6e207468652053554920636861696e210a4e6f74206a75737420616e6f746865722064696e6f736175722e20546865206f6e6520616e64206f6e6c7920657874696e6374696f6e2d70726f6f6620696e766573746d656e74206f6e205355492e205468652044696e6f53756972206d617920626520626c7565206275742074686520706f7274666f6c696f20697320677265656e212068747470733a2f2f64696e6f737569722e66756e2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_7b577f66b5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DINOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

