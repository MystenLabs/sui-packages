module 0xd43fdac253123a0425cfe9cf9bffc3fe4c84657b403581cef6ad573640ca25dc::testcnsix {
    struct TESTCNSIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTCNSIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTCNSIX>(arg0, 9, b"TESTCNSIX", b"Test Coin Six", b"That's a real sixth test coin!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTCNSIX>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTCNSIX>>(v2, @0xaca2a52083bd23b09cf8efe2c9b84903d04a46dba6c6f78b4ef06f8bbec1082);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTCNSIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

