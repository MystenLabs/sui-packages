module 0xb5a6dffb53b050e509970b5cf4e675bad455c9a5293db6c5fe3c0f1e33098d14::scaedal {
    struct SCAEDAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAEDAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAEDAL>(arg0, 6, b"SCAEDAL", b"Scaedal", b"SCAEDAL is a meme token launched on the Sui blockchain. It has no roadmap, no utility, and no expectations  and thats entirely intentional. In a sea of promises, rug pulls, and vaporware, $SCAEDAL offers something real: community power. We dont pretend to be something were not.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2025_04_29_at_10_11_14_d054f023c9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAEDAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAEDAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

