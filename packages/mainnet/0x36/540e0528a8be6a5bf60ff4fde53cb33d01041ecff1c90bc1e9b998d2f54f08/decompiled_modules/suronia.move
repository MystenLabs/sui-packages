module 0x36540e0528a8be6a5bf60ff4fde53cb33d01041ecff1c90bc1e9b998d2f54f08::suronia {
    struct SURONIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURONIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURONIA>(arg0, 6, b"SURONIA", b"SUI BEER", b"In a sea of Sui meme coins, Suronia is our liquid asset.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/corona_c7a92a685d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURONIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURONIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

