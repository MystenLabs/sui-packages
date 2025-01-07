module 0x74b306128ca64b828a766a497d3fa22589c7cee1bafdf4593ea1b64c9344679f::luckycat {
    struct LUCKYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCKYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCKYCAT>(arg0, 6, b"LuckyCAT", b"Lucky Cat", b"Lucky Cat is one of the main small statue of the store in asia where they believe cat is lucky on their businesses ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731556078852.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUCKYCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCKYCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

