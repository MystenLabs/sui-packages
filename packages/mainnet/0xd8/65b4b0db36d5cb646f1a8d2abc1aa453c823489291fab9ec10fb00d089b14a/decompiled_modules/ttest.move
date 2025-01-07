module 0xd865b4b0db36d5cb646f1a8d2abc1aa453c823489291fab9ec10fb00d089b14a::ttest {
    struct TTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTEST>(arg0, 6, b"Ttest", b"Turbotest", b"Turbo test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730666914452.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

