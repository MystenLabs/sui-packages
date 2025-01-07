module 0x64ab3c3f2610ecce962a536048e0c92943369702b1f9adcb99356470caf0054f::billysui {
    struct BILLYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILLYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILLYSUI>(arg0, 6, b"BillySui", b"To Billy", b"Pioneering a wave of billion dollar tokens on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730949170630.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BILLYSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILLYSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

