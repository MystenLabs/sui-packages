module 0xf528b8acd8693e837f2685cebe1c5487dd9e9dbd337b1ba734dbd28586cdb7af::mootun {
    struct MOOTUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOTUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOTUN>(arg0, 6, b"MOOTUN", b"Big Brother Moo Tun", b"In the peaceful rivers of Thailand, Moo Tun, a gentle and protective hippo, roams the waters, always watching over his playful younger sister, Moo Deng. Moo Tun is known for his calm demeanor and strong protective instincts, especially when it comes to his sister, who loves to splash and play in the river currents.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_14_34_09_d97c179919.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOTUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOTUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

