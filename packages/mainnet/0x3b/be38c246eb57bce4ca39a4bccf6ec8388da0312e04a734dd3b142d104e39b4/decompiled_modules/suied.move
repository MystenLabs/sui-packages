module 0x3bbe38c246eb57bce4ca39a4bccf6ec8388da0312e04a734dd3b142d104e39b4::suied {
    struct SUIED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIED>(arg0, 6, b"SUIED", b"SPEED", b"https://t.me/speedonsui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_21_00_17_13c555917d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIED>>(v1);
    }

    // decompiled from Move bytecode v6
}

