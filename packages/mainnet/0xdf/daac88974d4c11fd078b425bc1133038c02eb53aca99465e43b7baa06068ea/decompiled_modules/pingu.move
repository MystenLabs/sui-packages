module 0xdfdaac88974d4c11fd078b425bc1133038c02eb53aca99465e43b7baa06068ea::pingu {
    struct PINGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINGU>(arg0, 6, b"Pingu", b"Pingu Sui", b"The wildest meme coin in town! Sheriff Pingu & the gang are here for fun, community vibes, and a whole lotta action. Join the adventure!   X ACCOUNT : @pingussui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suingui_d1c59f32c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

