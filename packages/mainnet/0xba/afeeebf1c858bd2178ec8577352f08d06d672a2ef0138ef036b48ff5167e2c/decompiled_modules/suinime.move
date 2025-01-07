module 0xbaafeeebf1c858bd2178ec8577352f08d06d672a2ef0138ef036b48ff5167e2c::suinime {
    struct SUINIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINIME>(arg0, 6, b"SUINIME", b"SUINIME ", b"ara ara degen sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730967478812.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINIME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINIME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

