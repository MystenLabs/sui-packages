module 0xe1e75be932c919f9adb5aa4b046787ff4d05d53f6535e08ddf64f2ee19344d58::suister {
    struct SUISTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISTER>(arg0, 6, b"SUISTER", b"Suister GO", b"First Pokemon Themed Play to Earn Game on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibvvtnkbzdolk5z56sshd35w2llpgy2za6dogfwxig7xfu7zx7whu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISTER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

