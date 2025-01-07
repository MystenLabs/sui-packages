module 0x5eefd1835ce0579225bc4176c179aa33a620da29cee12b98a19ea08afd4978d2::rooster {
    struct ROOSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROOSTER>(arg0, 6, b"Rooster", b"Rooster sui", b"Don't bother me ,I'm a rooster , looking for real Chads  to push with me  to 10 million market cap we will do it step by step as we go along ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241025_214009_236_a8f737017a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROOSTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROOSTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

