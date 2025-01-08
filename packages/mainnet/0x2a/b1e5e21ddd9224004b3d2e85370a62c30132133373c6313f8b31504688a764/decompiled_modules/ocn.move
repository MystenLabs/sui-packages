module 0x2ab1e5e21ddd9224004b3d2e85370a62c30132133373c6313f8b31504688a764::ocn {
    struct OCN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<OCN>(arg0, 6, b"OCN", b"Ocean AI by SuiAI", b"This is orig", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/3d66d1388b0be636424653529a6dc2f6_561db279ab.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OCN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

