module 0x935863782088cd8aa38c455524a349d4c510f7546fa8f30c287df371792471f0::test_three {
    struct TEST_THREE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_THREE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_THREE>(arg0, 9, b"test_three", b"test_three", b"test dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST_THREE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_THREE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST_THREE>>(v1);
    }

    // decompiled from Move bytecode v6
}

