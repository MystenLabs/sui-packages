module 0xfdd25fc35a8ac0c8c1cc305505c1a58cc11fd4b5e4d7334ffe5682572b46dbed::suicat {
    struct SUICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAT>(arg0, 6, b"SUICAT", b"SUI CAT ($SUICAT)", b"The original cat-themed meme coin on the Sui blockchain! As the first of its kind, When it comes to cat coins on Sui, were the trailblazers setting the trend. Get in on the ground floor with Sui Cat and be part of the OG cat coin revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B_Gtk_D41a_400x400_22abecb8a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

