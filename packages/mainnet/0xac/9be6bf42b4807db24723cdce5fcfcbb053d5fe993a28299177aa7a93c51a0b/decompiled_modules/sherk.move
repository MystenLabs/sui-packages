module 0xac9be6bf42b4807db24723cdce5fcfcbb053d5fe993a28299177aa7a93c51a0b::sherk {
    struct SHERK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHERK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHERK>(arg0, 6, b"SHERK", b"Shrek or Shark", b"Some may call me Shrek, some may call me Shark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736041288686.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHERK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHERK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

