module 0x29aa7303445a846e9b403c5757cedda844d3680cd2e3af99199795598dadd8f6::ognerd {
    struct OGNERD has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGNERD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGNERD>(arg0, 9, b"OGnerd", b"nerdy ogre", b"OG nerd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7d4843d96db4069cab28eb674a8bed3dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OGNERD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGNERD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

