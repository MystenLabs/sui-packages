module 0x68c170e528d8c82ba0defa1337b41d6ef5096d8583f2d32650a8206fba922aa1::tornado {
    struct TORNADO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TORNADO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TORNADO>(arg0, 6, b"TORNADO", b"Sui TORNADO", b"tornado is a very powerful storm and will shake the SUI chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000114708_418ec04bbe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TORNADO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TORNADO>>(v1);
    }

    // decompiled from Move bytecode v6
}

