module 0x7289fc4bc1a224c6b0152b6e068346fb3ccb3c5ea37bb4cd05215f68b32124f4::sd {
    struct SD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SD>(arg0, 6, b"SD", b"Shut Down ", x"e2809c53687574646f776e207468652073797374656d2c20706f7765722075702074686520626c6f636b636861696e2ee2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1759572144318.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

