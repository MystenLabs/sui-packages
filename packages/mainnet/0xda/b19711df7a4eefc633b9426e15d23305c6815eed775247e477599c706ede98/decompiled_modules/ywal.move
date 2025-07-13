module 0xdab19711df7a4eefc633b9426e15d23305c6815eed775247e477599c706ede98::ywal {
    struct YWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: YWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YWAL>(arg0, 9, b"yWAL", b"Kai Vault WAL", b"Kai Vault yield-bearing WAL", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YWAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YWAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

