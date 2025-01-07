module 0x69d88a2613f2db77d1942e10be47530a4a9ec5393f9013cbc4cde74cc9965930::ptsd {
    struct PTSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTSD>(arg0, 6, b"PTSD", b"PTSD On Sui", b"Degens - once frolicking in the fields of decentralized dreams, now suffer from a new affliction  Meme Coin PTSD.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_0771cff53a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

