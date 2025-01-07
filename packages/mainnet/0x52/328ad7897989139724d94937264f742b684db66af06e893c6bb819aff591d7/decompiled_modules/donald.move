module 0x52328ad7897989139724d94937264f742b684db66af06e893c6bb819aff591d7::donald {
    struct DONALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONALD>(arg0, 6, b"DONALD", b"Donald Duckett Sui", b"Quack into the crypto craze with Donald Duck Meme Coin on Sui! This coin is as feisty and lovable as our favorite web-footed friend, bringing a splash of humor and a touch of nostalgia to your wallet. Dive into the pond of decentralized finance with a coin that's quacking up the blockchain world! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241215_004607_877_839bb3d3a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONALD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONALD>>(v1);
    }

    // decompiled from Move bytecode v6
}

