module 0xbdf6d59fa9742ca9f36d007c63443b24340e63c8f95ac17071b610e14b8f36ed::lucha {
    struct LUCHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCHA>(arg0, 6, b"LUCHA", b"Hawlucha", b"Hawlucha is a Fighting Flying-type Pokemon introduced in Generation VI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigclustrud6ivktfqu7jrjaukw2bxuhv5i62mmxxqwgyh3qkiqvye")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUCHA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

