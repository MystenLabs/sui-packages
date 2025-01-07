module 0x480d58888168facd1f65fcbbf1d59a5d7aa3e427c11712697212c94280bc980::suit {
    struct SUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIT>(arg0, 6, b"SuiT", b"Sui Traders", b"Tired of being farmed? ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_traders_20e2dd4035.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

