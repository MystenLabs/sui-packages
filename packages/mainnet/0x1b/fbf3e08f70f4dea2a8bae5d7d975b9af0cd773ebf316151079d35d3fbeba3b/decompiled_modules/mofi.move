module 0x1bfbf3e08f70f4dea2a8bae5d7d975b9af0cd773ebf316151079d35d3fbeba3b::mofi {
    struct MOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOFI>(arg0, 6, b"MOFI", b"MOVE FISH", b"JUST A FISH THAT MOVE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hop_fish_321a7c473f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

