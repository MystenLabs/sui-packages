module 0xf055720addacf3e03b470f6837e126f9a204939066f8f5cff549218ed244f601::whalemat {
    struct WHALEMAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALEMAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALEMAT>(arg0, 6, b"WHALEMAT", b"WHALE", b"Whale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0442_ddc22c1964.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALEMAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALEMAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

