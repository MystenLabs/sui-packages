module 0x68d5dff1f554a46a57e1406753eba6a1f0d84a5cffc4221117eaa9af881f784b::klaus {
    struct KLAUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLAUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLAUS>(arg0, 9, b"KLAUS", b"KLAUS", x"496e74726f647563696e6720224b4c4155532220e28093204c6974746c6520466973682c2042696720447265616d3a20666c69702074686520416d65726963616e20646f6c6c61722e2049207573656420746f206265206120746f702d74696572206174686c65746520616e206f6c796d70696320736b696572206c6976696e672074686520647265616d2e2e2e20616e64206e6f77212069e280996d2061206d656d652e2054656c656772616d3a2068747470733a2f2f742e6d652f6b6c6175736f6e7375692020547769747465723a2068747470733a2f2f782e636f6d2f6b6c6175736f6e7375692020576562736974653a2068747470733a2f2f6b6c6175736f6e7375692e73697465", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/klaussui/klaus/refs/heads/main/photo_2024-10-15_05-03-47.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KLAUS>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLAUS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KLAUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

