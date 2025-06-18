module 0x940112c07fc636fef6e9a0b533ef1768eab6b982b1f6896c5f61f3d0685a4007::sisi {
    struct SISI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SISI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SISI>(arg0, 6, b"SISI", b"$SISI", x"2453495349206973206e6f742061206c6f74206f66206d6f6e65792e20282453495349292e20546f6b656e6973696e6720746865206d6f73742069636f6e6963206472616d6120746865207472656e6368657320686176652065766572207365656e0a546865205269736520616e642046616c6c206f66204a616d65732057796e6e3a2057696c6c204865204d616b6520497420416c6c204261636b3f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5062_98b068ba03.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SISI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SISI>>(v1);
    }

    // decompiled from Move bytecode v6
}

