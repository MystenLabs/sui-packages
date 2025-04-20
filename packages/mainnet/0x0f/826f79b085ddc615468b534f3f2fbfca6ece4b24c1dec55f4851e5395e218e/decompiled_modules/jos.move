module 0xf826f79b085ddc615468b534f3f2fbfca6ece4b24c1dec55f4851e5395e218e::jos {
    struct JOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOS>(arg0, 6, b"JOS", b"Jinro on Sui", x"496e73706972656420627920746865206c6567656e64617279206472696e6b2c206e6f7720666c6f77696e67206f6e2053756920636861696e2e0a426f726e2066726f6d2074686520737069726974206f66204a696e726f2c206d61646520666f722074686520626f6c642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidqhppzieswzthgibbhe36hmdy6pwmshsbfqxm5fwel3dfm5vikoa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

