module 0x1fd1842beb01f6150e6b08966cd895555a728c386fa2449511226d1c2a5ab933::geco {
    struct GECO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GECO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GECO>(arg0, 6, b"GECO", b"Geco", x"244765636f20546865204765636b6f20f09fa68e0a4669727374204d6174742046757269652773204d656d6520636f696e206f6e20737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734788341947.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GECO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GECO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

