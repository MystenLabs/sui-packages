module 0xd5dc78fbe33014d2b8178344cf60a9e8dd9673c233fe4ef80eb0a6377c696418::zorix {
    struct ZORIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZORIX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ZORIX>(arg0, 6, b"ZORIX", b"ZORIX AI  by SuiAI", b"Meet ZORIX ,  the next wallet tracker and AI trading bot Agent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/small_logo_8577836ef1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZORIX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZORIX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

