module 0x6454cf25944d3ab2064b29feb3fd0dc719456883ca5941d6a6394a8263187704::sui_dawg {
    struct SUI_DAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_DAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_DAWG>(arg0, 6, b"Sui_DAWG", b"DAWG", b"woof woof woof woof", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731012571685.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_DAWG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_DAWG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

