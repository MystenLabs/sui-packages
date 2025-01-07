module 0x5900938dd88958f485702345a6666f9170c933fc507a7834d771fbc5346cb868::aia {
    struct AIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIA>(arg0, 6, b"AiA", b"Ai Agents", b"Ai Agents is the meme coin of the Ai revolution.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9397_bdce3983ea.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

