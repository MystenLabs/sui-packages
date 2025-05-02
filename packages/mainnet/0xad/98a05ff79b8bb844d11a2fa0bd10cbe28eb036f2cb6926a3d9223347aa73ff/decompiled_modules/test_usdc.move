module 0xad98a05ff79b8bb844d11a2fa0bd10cbe28eb036f2cb6926a3d9223347aa73ff::test_usdc {
    struct TEST_USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_USDC>(arg0, 9, b"tUSDC", b"Test USDC", 0x1::vector::empty<u8>(), 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/usdc_03b37ed889.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST_USDC>(&mut v2, 1000000000000000, @0xa902504c338e17f44dfee1bd1c3cad1ff03326579b9cdcfe2762fc12c46fc033, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_USDC>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST_USDC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

