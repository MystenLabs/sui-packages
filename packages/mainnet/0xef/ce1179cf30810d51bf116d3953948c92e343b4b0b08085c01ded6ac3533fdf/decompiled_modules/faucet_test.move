module 0xefce1179cf30810d51bf116d3953948c92e343b4b0b08085c01ded6ac3533fdf::faucet_test {
    struct FAUCET_TEST has drop {
        dummy_field: bool,
    }

    public entry fun faucet(arg0: &mut 0x2::coin::TreasuryCap<FAUCET_TEST>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FAUCET_TEST>(arg0, 100, arg1, arg2);
    }

    fun init(arg0: FAUCET_TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAUCET_TEST>(arg0, 2, b"FAUCET_TEST", b"FC", b"TESTCOIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/44160914")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAUCET_TEST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAUCET_TEST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

