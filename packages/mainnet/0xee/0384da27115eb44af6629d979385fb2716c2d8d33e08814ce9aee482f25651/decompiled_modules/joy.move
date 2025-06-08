module 0xee0384da27115eb44af6629d979385fb2716c2d8d33e08814ce9aee482f25651::joy {
    struct JOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOY>(arg0, 6, b"JOY", b"Joy on Sui", b"In a forgotten corner of the metaverse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidddfuli3ndmtijdyc4bfjru2ge6jjjtwzyizvtrqn7gvxs4mcf5y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

