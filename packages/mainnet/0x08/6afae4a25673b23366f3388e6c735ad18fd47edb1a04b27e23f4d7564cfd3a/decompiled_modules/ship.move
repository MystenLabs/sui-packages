module 0x86afae4a25673b23366f3388e6c735ad18fd47edb1a04b27e23f4d7564cfd3a::ship {
    struct SHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIP>(arg0, 6, b"SHIP", b"ship token", b"SHP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1a0c74710fb2_3e8b16b8be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

