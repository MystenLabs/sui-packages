module 0xe308152981890e980b18d72aa84c7a3a9c917766dab615b0077db798b9d5e7b3::mooshi {
    struct MOOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOSHI>(arg0, 6, b"MOOSHI", b"MooshiSuishi", x"54686973206c6974746c65206375746965207061746f6f74696520676f7420727567676564206f6e20536f6c616e6120736f2068652077616e64657265642061726f756e642073616420616e64206c6f6e656c7920756e74696c20686520666f756e642061206e657720686170707920686f6d65206f6e202453554920f09fa69b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732137968417.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOOSHI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOSHI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

