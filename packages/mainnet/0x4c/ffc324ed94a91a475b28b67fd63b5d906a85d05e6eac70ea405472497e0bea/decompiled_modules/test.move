module 0x4cffc324ed94a91a475b28b67fd63b5d906a85d05e6eac70ea405472497e0bea::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"test", b"Test", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sui-coin-launchpad.preview.emergentagent.com/api/files/suipump/logos/0xb5e324e018645687510f66124d41c4c9d99bb8b14cae50f52ddd42085c71f13c/6ee5f29f-a7e7-4092-8cdc-12dca09adb14.png")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

