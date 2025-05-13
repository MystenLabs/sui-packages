module 0xf56e419078fa04a916110b858b81a27300911909856d95351e889644c02847cf::mew {
    struct MEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEW>(arg0, 6, b"Mew", b"Mewtwo", b"Mewtwo Legendary pokemon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihgf23qdqqyk53cflgdqrk6ojoxgdkdcbe5t4kuskug7oygnrp7ga")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

