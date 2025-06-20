module 0x8ed54f7be5772b57e1113b0103113d4ca7c55a15b02bb65f347bb120b5b3da9b::shib {
    struct SHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIB>(arg0, 6, b"SHIB", b"Shiba inu", b"Shiba inu ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750440818885.31")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

