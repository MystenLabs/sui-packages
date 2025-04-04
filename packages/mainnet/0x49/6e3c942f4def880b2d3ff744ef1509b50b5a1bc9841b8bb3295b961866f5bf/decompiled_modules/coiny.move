module 0x496e3c942f4def880b2d3ff744ef1509b50b5a1bc9841b8bb3295b961866f5bf::coiny {
    struct COINY has drop {
        dummy_field: bool,
    }

    fun init(arg0: COINY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COINY>(arg0, 9, b"COINY", b"cointy", b"NEW MEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/758f1b88522ae9508fd930f42eb4b0c1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COINY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COINY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

