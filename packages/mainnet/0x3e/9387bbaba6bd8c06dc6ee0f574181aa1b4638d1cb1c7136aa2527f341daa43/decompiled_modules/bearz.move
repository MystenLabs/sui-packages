module 0x3e9387bbaba6bd8c06dc6ee0f574181aa1b4638d1cb1c7136aa2527f341daa43::bearz {
    struct BEARZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEARZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEARZ>(arg0, 6, b"BEARZ", b"Sui Bears", b"At Sui Bears, were more than memes. Were building a thriving ecosystem where the wild meets Web3. Join the pack as we bridge communities with innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_31_13_45_42_bde78437d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEARZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEARZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

