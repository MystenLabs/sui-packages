module 0xc6c9f1a3f51a2f759d5c25d1fc7baebf776e5ea56d178c6c5c5fb926d7400477::suiclam {
    struct SUICLAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICLAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICLAM>(arg0, 6, b"SuiClam", b"Sui Clam", b"Clam Token on Sui Blockchain: Where Innovation Meets Humor!  Dive into the world of Clam Token, a groundbreaking meme token built on the cutting-edge Sui blockchain. Combining fun, community-driven vibes with high-speed and low-cost transactions, Clam Token isnt just another meme,its a pearl in the crypto sea! Join the Clamfam and ride the wave to a new era of blockchain memes that truly make a splash.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7296_93d18c94cd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICLAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICLAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

