module 0x260ecdc21837f7d7e2282dcaef83efcd9f6ddd94c6cf91365190abc0bfbf97c7::xdd {
    struct XDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: XDD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<XDD>(arg0, 6, b"XDD", b"Vgdd by SuiAI", b"F", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/image_4912734807480650887_b1c5ff7461.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XDD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XDD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

