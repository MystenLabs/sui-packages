module 0xee160fb88829ed3d25ba8e9ae227f81a3fa4f883fa5cbab5caa04db7cc35e2dc::wink {
    struct WINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINK>(arg0, 6, b"WINK", b"Wink Realm", x"4578706c6f72696e6720746865207265616c6d20696e20736561726368206f66206d6f7265204d696e692d57696e6b730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739396901847.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WINK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

