module 0x855655968eea4b2368cf3708ca3c6f45167a9d558f0f4353767dd4f709f973ae::miketyson {
    struct MIKETYSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKETYSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKETYSON>(arg0, 6, b"MIKETYSON", b"MIKE TYSON", x"4c657473206669676874204d696b650a0a4d696b65205479736f6e2077696c6c2077696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000034130_e291a47ed2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKETYSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIKETYSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

