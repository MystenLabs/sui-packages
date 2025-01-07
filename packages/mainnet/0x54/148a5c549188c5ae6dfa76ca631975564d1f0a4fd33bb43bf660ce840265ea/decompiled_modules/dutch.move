module 0x54148a5c549188c5ae6dfa76ca631975564d1f0a4fd33bb43bf660ce840265ea::dutch {
    struct DUTCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUTCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUTCH>(arg0, 6, b"DUTCH", b"FLYING DUTCHMAN", b"\"You're part of my crew now.\" Said Flying Dutchman.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000081133_39c375f82e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUTCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUTCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

