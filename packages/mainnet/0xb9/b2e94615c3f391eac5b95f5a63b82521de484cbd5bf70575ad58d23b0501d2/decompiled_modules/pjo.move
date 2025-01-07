module 0xb9b2e94615c3f391eac5b95f5a63b82521de484cbd5bf70575ad58d23b0501d2::pjo {
    struct PJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PJO>(arg0, 6, b"PJO", b"ParisJO", x"e2809c4661737465722c204869676865722c205374726f6e67657220e2809320546f676574686572e2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmQy3QpRcQjt6VAev8FR5MVbR7ewM3Suewk7GgPbMvpzp5?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PJO>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PJO>>(v2, @0xaefe9f5825d1ad6b9f65f2ade3677c75dcf8035a416ca6b9a9dbc19465463bd5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PJO>>(v1);
    }

    // decompiled from Move bytecode v6
}

