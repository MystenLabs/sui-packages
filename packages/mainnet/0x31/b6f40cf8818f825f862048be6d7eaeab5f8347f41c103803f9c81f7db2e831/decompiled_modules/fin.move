module 0x31b6f40cf8818f825f862048be6d7eaeab5f8347f41c103803f9c81f7db2e831::fin {
    struct FIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIN>(arg0, 6, b"FIN", b"SUIFIN", b"Fin the fish ainot just a meme, he is a movement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia7lrb5ng25mfmmxhum6vs7dflat6sburbupznnedhm66o3wmglq4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

