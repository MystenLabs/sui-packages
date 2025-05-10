module 0x1e92f75895d134bc0872777c8be74b633951f7e870d763140b3da6a9a5f48418::pepsui {
    struct PEPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPSUI>(arg0, 6, b"PEPSUI", b"PEPSUI ON SUI", b"The drink that will make you crazy about the SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihadnxgqo256a7vkl6mmg5emej6fsj7zv6rg2nfx4zyir65db2atm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEPSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

