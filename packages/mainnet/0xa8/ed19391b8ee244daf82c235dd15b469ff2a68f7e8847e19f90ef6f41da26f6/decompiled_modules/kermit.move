module 0xa8ed19391b8ee244daf82c235dd15b469ff2a68f7e8847e19f90ef6f41da26f6::kermit {
    struct KERMIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KERMIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KERMIT>(arg0, 6, b"KERMIT", b"SuiKermit", b"Introducing Sui Kermit, the sensational hopping meme frog of Sui Blockchain! With his infectious charm and undeniable meme-worthy presence, Sui Kermit is capturing the hearts of internet users everywhere. This unique and quirky character brings a breath of fresh air to the digital space, spreading joy and entertainment to all who encounter him. Join the Sui Blockchain community and dive into the fun-filled world of Sui Kermit - you won't want to miss out on this ribbiting adventure!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_19_50_15_ec113bf32b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KERMIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KERMIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

