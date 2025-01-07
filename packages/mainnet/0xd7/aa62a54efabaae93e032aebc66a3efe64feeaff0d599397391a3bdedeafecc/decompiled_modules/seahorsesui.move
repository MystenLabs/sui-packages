module 0xd7aa62a54efabaae93e032aebc66a3efe64feeaff0d599397391a3bdedeafecc::seahorsesui {
    struct SEAHORSESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAHORSESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAHORSESUI>(arg0, 6, b"SeahorseSui", b"Seahorse on Sui", b"Seahorse Token is a meme-inspired cryptocurrency built on the Sui blockchain. Combining humor with innovation, it offers a fun and engaging entry point for the crypto community. Powered by Suis scalable and secure infrastructure, Seahorse Token aims to foster a vibrant ecosystem of holders and enthusiasts, blending meme culture with blockchain technology.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7314_e5ae610081.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAHORSESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEAHORSESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

