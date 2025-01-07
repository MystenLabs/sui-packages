module 0xe27f66f923db9b37eea60ce95eab88b729862568027326ddb38c26e0bada0bd7::bar {
    struct BAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAR>(arg0, 6, b"BAR", b"Beaver", b"The Beaver community is expanding, and it's time to celebrate your creativity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730970481876.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

