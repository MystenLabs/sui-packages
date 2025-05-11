module 0x8217d81c342f8aee317abf0cea5e1436840050a25e8c89ba17f811279a4db35d::pirdog {
    struct PIRDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIRDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIRDOG>(arg0, 6, b"PIRDOG", b"Pirdog", b"Pirates of Sui $PIRDOG is a meme coin sailing the Sui network, designed purely for fun and community engagement. This lighthearted token aims to unite adventurers across the Sui ecosystem, helping everyone reach their goals while embracing the spirit of camaraderie and exploration. Join the crew and chart a course for success with Pirates of Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000068814_cf33611f6d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIRDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIRDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

