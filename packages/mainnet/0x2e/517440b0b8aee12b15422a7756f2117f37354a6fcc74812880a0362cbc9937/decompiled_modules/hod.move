module 0x2e517440b0b8aee12b15422a7756f2117f37354a6fcc74812880a0362cbc9937::hod {
    struct HOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HOD>(arg0, 6, b"HOD", b"HornDog by SuiAI", b"Hello, something like that, yes yes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Designer_e4f80c347e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HOD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

