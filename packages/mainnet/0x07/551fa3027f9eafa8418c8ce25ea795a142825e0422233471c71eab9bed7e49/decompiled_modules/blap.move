module 0x7551fa3027f9eafa8418c8ce25ea795a142825e0422233471c71eab9bed7e49::blap {
    struct BLAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAP>(arg0, 6, b"BLAP", b"Blap Sui", b"BLAP is a hybrid character formed from the combination of the four members of the Boys Club: Brett, Pepe, Andy, and Landwolf.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih2y7y6k47ulnfhx22cbt6tsudwlsr7sohvoogrb4te7a2foludge")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLAP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

