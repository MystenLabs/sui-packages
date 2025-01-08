module 0x1a6df0e09764af25128cb10d45cfdf0b0a3bdb2afbecdb5d84b4bee51d2ae306::brian {
    struct BRIAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRIAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRIAN>(arg0, 6, b"Brian", b"Brian Griffin", b"I'm brian from family, chilli guy here buy and hold next million meme here ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014100_9623443ae8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRIAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRIAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

