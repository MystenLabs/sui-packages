module 0x78ca5b69b86e8985305efa07d2796bd50c9390ef38e98173827dbf980e7163a::bumsfan {
    struct BUMSFAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUMSFAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUMSFAN>(arg0, 6, b"BumsFan", b"Bums Fan", b"Here we go all FAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020418_40d3380abc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUMSFAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUMSFAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

