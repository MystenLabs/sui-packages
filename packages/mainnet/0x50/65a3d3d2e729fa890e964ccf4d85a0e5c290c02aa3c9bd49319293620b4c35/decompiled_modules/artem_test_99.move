module 0x5065a3d3d2e729fa890e964ccf4d85a0e5c290c02aa3c9bd49319293620b4c35::artem_test_99 {
    struct ARTEM_TEST_99 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARTEM_TEST_99, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARTEM_TEST_99>(arg0, 6, b"ARTEM_TEST_99", b"ARTEM test coin", b"to the moon coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/Qme31MiTozmuadZbegQNq4X1fThLtcw7mPKzePjvdEFcSJ?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ARTEM_TEST_99>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARTEM_TEST_99>>(v2, @0xaca2a52083bd23b09cf8efe2c9b84903d04a46dba6c6f78b4ef06f8bbec1082);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARTEM_TEST_99>>(v1);
    }

    // decompiled from Move bytecode v6
}

