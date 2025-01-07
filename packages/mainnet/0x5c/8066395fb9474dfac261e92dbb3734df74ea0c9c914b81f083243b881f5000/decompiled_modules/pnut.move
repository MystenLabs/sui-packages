module 0x5c8066395fb9474dfac261e92dbb3734df74ea0c9c914b81f083243b881f5000::pnut {
    struct PNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUT>(arg0, 6, b"PNUT", b"Peanut the Squirrel on SUI", x"506e7574206f6e20537569206973206865726520746f2072616e6765202e2e0a526970205065616e757420737175697272656c20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2917_cec783dba8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

