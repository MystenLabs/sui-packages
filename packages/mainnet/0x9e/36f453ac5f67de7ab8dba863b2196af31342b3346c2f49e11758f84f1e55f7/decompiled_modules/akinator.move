module 0x9e36f453ac5f67de7ab8dba863b2196af31342b3346c2f49e11758f84f1e55f7::akinator {
    struct AKINATOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKINATOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKINATOR>(arg0, 6, b"Akinator", b"Akinator sui", b"does akinator know ansem?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FLATTY_ed52ecd82e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKINATOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKINATOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

