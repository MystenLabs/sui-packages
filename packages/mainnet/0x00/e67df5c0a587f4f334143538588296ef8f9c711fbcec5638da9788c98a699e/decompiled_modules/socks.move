module 0xe67df5c0a587f4f334143538588296ef8f9c711fbcec5638da9788c98a699e::socks {
    struct SOCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOCKS>(arg0, 6, b"SOCKS", b"SOCKS CTO", b"THE OG dev jeeted but we can still run it back.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidmddbdmmbmqy7qxem5sykfohfniroeblwoceml46ipjjzjrr4lgy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOCKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SOCKS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

