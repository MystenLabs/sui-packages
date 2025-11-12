module 0x8821d8a630e40ea6007ae410c05a1c5bc411b45d3532e5c625a989525ce40fcc::smtest {
    struct SMTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMTEST>(arg0, 6, b"SMtest", b"samtest", b"avbc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1762920003517.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMTEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMTEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

