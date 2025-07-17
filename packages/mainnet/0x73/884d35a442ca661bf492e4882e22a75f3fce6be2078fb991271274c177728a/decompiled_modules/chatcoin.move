module 0x73884d35a442ca661bf492e4882e22a75f3fce6be2078fb991271274c177728a::chatcoin {
    struct CHATCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHATCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHATCOIN>(arg0, 6, b"CHATCOIN", b"chatonsui", b"The first decentralized chat room website on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifyebgqccrysaw4mkkxog4s7cfnhlibc2mctrqdqiqdvnu6vdmggq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHATCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHATCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

