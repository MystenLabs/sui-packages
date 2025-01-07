module 0x68e4209710b45da26db91eb60e66a56c91bcfce4e8c671c8abee92e28bea368::suinguin {
    struct SUINGUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINGUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINGUIN>(arg0, 6, b"SUINGUIN", b"Suinguin - The Sui Seal", b"Suinguin the Penguin is a rogue memecoin on the Sui blockchain, led by a rebellious, sharp-witted penguin with a flair for mischief and disruption. Born in the icy depths, Suinguin thrives on bold moves, daring stunts, and a community-driven mission to shake up the crypto landscape with a cold, calculated edge.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_01_10_48_06_a89c07b9ee.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINGUIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINGUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

