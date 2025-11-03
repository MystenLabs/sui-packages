module 0xa0ed216a99c16195fe59b3c1319c07e9b8c7fd001338aa46de628fccdef0e13f::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://talus.network/us-icon.png";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://talus.network/us-icon.png"))
        };
        let (v2, v3) = 0x2::coin::create_currency<TEST>(arg0, 9, b"TALUS-TEST", b"Talus Test Token", b"Test token for Talus deployment verification - DO NOT USE IN PRODUCTION", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST>>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST>>(0x2::coin::mint<TEST>(&mut v4, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

