module 0xfcb2fee1d6db2bd55d06bdfecb1b0389bd79c6cd15e7fc08126cb697b2c5d405::surfer {
    struct SURFER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURFER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURFER>(arg0, 6, b"SURFER", b"SuiSurfer", b"Sui Surfer is a vibrant new memecoin designed to ride the waves of the Sui blockchain's thriving ecosystem. Featuring an alien surfer mascot, this token combines fun, community-driven engagement with the high-speed, low-cost transaction capabilities of Sui. Launching exclusively on MovePump, Sui Surfer aims to capture the spirit of adventure and innovation, making it a standout addition to the growing collection of Sui-based tokens. * TG Coming soon . The Link for Telegram Channel will be posted on our X.com Profile ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aliensui_overlay_modified_4196a88353.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURFER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURFER>>(v1);
    }

    // decompiled from Move bytecode v6
}

