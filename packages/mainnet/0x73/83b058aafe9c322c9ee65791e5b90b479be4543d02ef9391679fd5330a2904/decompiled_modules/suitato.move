module 0x7383b058aafe9c322c9ee65791e5b90b479be4543d02ef9391679fd5330a2904::suitato {
    struct SUITATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITATO>(arg0, 6, b"SUITATO", b"Suitato Sui", b"Suitato, the potato in a suit on SUI, is the ultimate meme legend. A smug spud rocking a tiny tie, strutting around like he owns the place. M", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000382_ac5de39672.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

