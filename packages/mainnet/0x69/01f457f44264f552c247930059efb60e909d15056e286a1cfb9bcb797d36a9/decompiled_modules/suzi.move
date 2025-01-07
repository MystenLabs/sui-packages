module 0x6901f457f44264f552c247930059efb60e909d15056e286a1cfb9bcb797d36a9::suzi {
    struct SUZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUZI>(arg0, 6, b"Suzi", b"sui uzi", b"so anyway, i started blasting...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731138372412.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUZI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUZI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

