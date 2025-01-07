module 0x39c8a358a5607f4ef74451ccb318c3c762b13b4d6ba089c664882bd247a3a2ba::lihua6 {
    struct LIHUA6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIHUA6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIHUA6>(arg0, 6, b"Lihua6", b"lihua", b"I don't like being called Li Hua", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730894897705.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIHUA6>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIHUA6>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

