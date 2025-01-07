module 0x63fe95ff22cc593ba940d543064cf7a013051f58328737d9077b6442bee044c9::bfox {
    struct BFOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFOX>(arg0, 6, b"BFox", b"Blue Fox", b"Are you ready? Blue Fox is an innovative meme coin built on the Sui network, with the goal of becoming a leader in the community-based crypto world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000069802_700d068323.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BFOX>>(v1);
    }

    // decompiled from Move bytecode v6
}

