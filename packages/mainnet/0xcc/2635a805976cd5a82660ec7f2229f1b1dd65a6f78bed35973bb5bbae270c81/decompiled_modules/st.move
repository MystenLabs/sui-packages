module 0xcc2635a805976cd5a82660ec7f2229f1b1dd65a6f78bed35973bb5bbae270c81::st {
    struct ST has drop {
        dummy_field: bool,
    }

    fun init(arg0: ST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ST>(arg0, 6, b"St", b"Suilestial token", b"Sky is not our limit!Moon we go!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000172927_d2fb163d28.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ST>>(v1);
    }

    // decompiled from Move bytecode v6
}

