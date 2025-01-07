module 0xf92da93c37d971d5566a8f09b27ac64d759682aceb4e7c4b834d3d028b321f65::billion {
    struct BILLION has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILLION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILLION>(arg0, 6, b"Billion", b"bili the lion", b"Bili the lion. The most cute lion on internet i have ever see. On a mission to be worth billions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bollion_434e4c7d2a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILLION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BILLION>>(v1);
    }

    // decompiled from Move bytecode v6
}

