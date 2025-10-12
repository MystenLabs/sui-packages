module 0x3a948f52dac0698aca0dc181ba709cff6530e40207b9aa29a858e7dd3618474c::Winter {
    struct WINTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINTER>(arg0, 9, b"WONDER", b"Winter", b"winter wonderland", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/G2uw0IbW4AAzDtx?format=jpg&name=small")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WINTER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINTER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

