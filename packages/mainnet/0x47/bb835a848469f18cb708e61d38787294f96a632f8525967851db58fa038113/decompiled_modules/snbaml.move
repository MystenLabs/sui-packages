module 0x47bb835a848469f18cb708e61d38787294f96a632f8525967851db58fa038113::snbaml {
    struct SNBAML has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNBAML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNBAML>(arg0, 6, b"SNBAML", b"SuiNothingButAMemeLoaf", b"Literally nothing but a meme loaf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/memeloaf_6fca215286.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNBAML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNBAML>>(v1);
    }

    // decompiled from Move bytecode v6
}

