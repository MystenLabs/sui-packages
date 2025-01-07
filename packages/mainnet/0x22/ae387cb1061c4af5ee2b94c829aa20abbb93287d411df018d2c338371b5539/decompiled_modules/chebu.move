module 0x22ae387cb1061c4af5ee2b94c829aa20abbb93287d411df018d2c338371b5539::chebu {
    struct CHEBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEBU>(arg0, 6, b"Chebu", b"Cheburashka", x"24436865627520746f206265206c61756e6368206f6e20547572626f730a0a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730959711475.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEBU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEBU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

