module 0x4b12776a6435f21b939a90f9303b7ddebd25c4eab1383db419b3ac38365fe60c::coins {
    struct COINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: COINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COINS>(arg0, 6, b"COINS", b"Come on!", b"coins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_9c020e1088.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COINS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COINS>>(v1);
    }

    // decompiled from Move bytecode v6
}

