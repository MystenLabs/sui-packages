module 0x8bc08559f0e09fbecd2e07c49e32d859fc0816e59b4748d805cd9f84c87de965::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST>(arg0, 9, b"Test", b"Test", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sui-coin-launchpad.preview.emergentagent.com/api/files/suipump/logos/0xb5e324e018645687510f66124d41c4c9d99bb8b14cae50f52ddd42085c71f13c/c82c52c7-eb3a-4eb0-8688-f016e6b4afad.png")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

