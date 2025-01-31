module 0xcc9166a9bd806a4c2ea04629f177a6a3c0fd12937a64d5a0097c913c93b8a33f::custify {
    struct CUSTIFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUSTIFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUSTIFY>(arg0, 6, b"Custify", b"Custify AI", b"Custify AI is a customer service agent powered by advanced Artificial Intelligence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738347013798.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUSTIFY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUSTIFY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

