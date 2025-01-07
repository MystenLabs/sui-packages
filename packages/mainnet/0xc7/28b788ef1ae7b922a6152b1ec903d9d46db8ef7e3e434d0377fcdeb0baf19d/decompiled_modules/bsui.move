module 0xc728b788ef1ae7b922a6152b1ec903d9d46db8ef7e3e434d0377fcdeb0baf19d::bsui {
    struct BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUI>(arg0, 6, b"BSUI", b"Bunnyon SUI", b"meet with blue bunny and print more moneyyyyyy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730965272772.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

