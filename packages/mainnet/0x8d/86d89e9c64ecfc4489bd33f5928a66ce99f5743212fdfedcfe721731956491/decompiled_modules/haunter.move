module 0x8d86d89e9c64ecfc4489bd33f5928a66ce99f5743212fdfedcfe721731956491::haunter {
    struct HAUNTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAUNTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAUNTER>(arg0, 6, b"Haunter", b"Haunter on sui", b"In total darkness, where nothing is visible, Haunter lurks, silently stalking its next victim. It likes to lurk in the dark and tap shoulders with a gaseous ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiael6haxsybwnd6ugpjr2ibamxsdqo3qelgfl6jtm3zv2litzfypq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAUNTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAUNTER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

