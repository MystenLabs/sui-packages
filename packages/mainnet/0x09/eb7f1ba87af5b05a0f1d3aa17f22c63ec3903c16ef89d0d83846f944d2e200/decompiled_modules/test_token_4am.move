module 0x9eb7f1ba87af5b05a0f1d3aa17f22c63ec3903c16ef89d0d83846f944d2e200::test_token_4am {
    struct TEST_TOKEN_4AM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_TOKEN_4AM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_TOKEN_4AM>(arg0, 6, b"TEST_TOKEN_4am", b"testtoken4am", b"testtoken4am description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.seadn.io/gae/2hDpuTi-0AMKvoZJGd-yKWvK4tKdQr_kLIpB_qSeMau2TNGCNidAosMEvrEXFO9G6tmlFlPQplpwiqirgrIPWnCKMvElaYgI-HiVvXc?auto=format&dpr=1&w=1000")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST_TOKEN_4AM>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_TOKEN_4AM>>(v2, @0x9a32c41920a66f4919a3d011dac7d45fb79d2629d4c5dce937d550339bbad8e2);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST_TOKEN_4AM>>(v1);
    }

    // decompiled from Move bytecode v6
}

