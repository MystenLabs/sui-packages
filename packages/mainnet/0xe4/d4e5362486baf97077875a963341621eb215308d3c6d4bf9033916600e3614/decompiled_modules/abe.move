module 0xe4d4e5362486baf97077875a963341621eb215308d3c6d4bf9033916600e3614::abe {
    struct ABE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABE>(arg0, 6, b"Abe", b"Abe - SUI dog", b"$ABE is a playful meme token project inspired by Abe, the beloved dog of Uniswap CEO Hayden Adams. This fun initiative taps into the whimsical nature of dog culture and the vibrant world of crypto. ABE invites dog lovers and meme enthusiasts to join a community that values joy, creativity, and connection.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_21_21_29_51e364131d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABE>>(v1);
    }

    // decompiled from Move bytecode v6
}

