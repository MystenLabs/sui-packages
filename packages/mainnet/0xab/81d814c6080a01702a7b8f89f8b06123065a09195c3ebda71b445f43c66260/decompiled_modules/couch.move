module 0xab81d814c6080a01702a7b8f89f8b06123065a09195c3ebda71b445f43c66260::couch {
    struct COUCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: COUCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COUCH>(arg0, 6, b"COUCH", b"Couch on Sui", b"Sit back and relax with $COUCH on Sui. The comfiest coin on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_ed446969c2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COUCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COUCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

