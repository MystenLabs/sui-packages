module 0xf5b246e2882c638cf6abca931a20492e5255fcb4461843d8bd53af915c1ba368::tirex {
    struct TIREX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIREX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIREX>(arg0, 6, b"TIREX", b"Tirex on Sui", b"First Tirex on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tirex16_47d35ca6ac.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIREX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIREX>>(v1);
    }

    // decompiled from Move bytecode v6
}

