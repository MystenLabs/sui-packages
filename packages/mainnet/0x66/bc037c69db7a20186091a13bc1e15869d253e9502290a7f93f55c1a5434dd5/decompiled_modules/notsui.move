module 0x66bc037c69db7a20186091a13bc1e15869d253e9502290a7f93f55c1a5434dd5::notsui {
    struct NOTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTSUI>(arg0, 6, b"NOTSUI", b"Not Sui", b"Not sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia27popchiu3xbf3gysquuefc5whlo6ic3pve7lteiud7y3hkk43m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NOTSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

