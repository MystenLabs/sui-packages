module 0x536e913400b9bebee885307230e6db8c7c615ae180fd11684624bb4fc3cbacb8::cindy {
    struct CINDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CINDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CINDY>(arg0, 6, b"CINDY", b"Cindy Lou on Sui", b"The beloved cutie who saved the Christmas on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054533_89bfe91c74.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CINDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CINDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

