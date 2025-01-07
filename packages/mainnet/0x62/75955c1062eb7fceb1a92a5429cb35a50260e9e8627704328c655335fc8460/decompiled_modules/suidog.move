module 0x6275955c1062eb7fceb1a92a5429cb35a50260e9e8627704328c655335fc8460::suidog {
    struct SUIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOG>(arg0, 6, b"SUIDOG", b"SUI DOG", b"The original dog-themed meme coin on the Sui blockchain! As the first of its kind, When it comes to dog coins on Sui, were the trailblazers setting the trend. Get in on the ground floor with Sui Dog and be part of the OG dog coin revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/08140bc2_de34_40a1_bb5e_5e41096729d5_638c5c1c35.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

