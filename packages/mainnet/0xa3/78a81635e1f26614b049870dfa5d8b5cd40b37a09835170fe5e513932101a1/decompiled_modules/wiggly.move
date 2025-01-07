module 0xa378a81635e1f26614b049870dfa5d8b5cd40b37a09835170fe5e513932101a1::wiggly {
    struct WIGGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIGGLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIGGLY>(arg0, 6, b"WIGGLY", b"WIGGLY WEASEL", b"Slipping through the meme cracks and grabbing gains. Wiggly Weasel is unstoppable!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_041032254_3c2f1e2ccc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIGGLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIGGLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

