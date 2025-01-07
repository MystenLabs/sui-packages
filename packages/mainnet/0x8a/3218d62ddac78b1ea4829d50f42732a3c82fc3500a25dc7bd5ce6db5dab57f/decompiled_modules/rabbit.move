module 0x8a3218d62ddac78b1ea4829d50f42732a3c82fc3500a25dc7bd5ce6db5dab57f::rabbit {
    struct RABBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RABBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RABBIT>(arg0, 6, b"RABBIT", b"SuiRabbit", b"SuiRabbit, the majestic king of the ocean is ready to takeover the world of Sui memecoins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_12_T233258_089_dc2a1fcb42.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RABBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RABBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

