module 0x2f53595316c5f213bf81acab0195564cd728a7c5eeaf98c4fdea38bc82cb05f2::hippopump {
    struct HIPPOPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPOPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPOPUMP>(arg0, 6, b"HIPPOPUMP", b"HIPPO PUMP", b"Fan page & CTO driven meme of the cutest $HIPPOPUMP in the whole wide world ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8ohc_TVBD_400x400_ab1bbd6de6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPOPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIPPOPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

