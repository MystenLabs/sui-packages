module 0xc5e98bc323058b15670783c8ba8ba2168d411f6cbad6c34f9d6473b21c583257::seadog {
    struct SEADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEADOG>(arg0, 6, b"SeaDog", b"SeaDogSui", b"Welcome aboard the SEADOG armada, the greatest dog meme to ever sail the Sui blockchain! From the depths of the digital oceans, SEADOG has emerged as the fearless captain of a new era in meme coins. Every chain has its heroes, and Sui has SEADOG, the loyal, adventurous, and meme-tastic canine ready to conquer the crypto seas.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_19_27_38_7859ab59f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEADOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEADOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

