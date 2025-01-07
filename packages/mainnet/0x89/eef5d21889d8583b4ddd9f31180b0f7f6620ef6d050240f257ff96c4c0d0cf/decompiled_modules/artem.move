module 0x89eef5d21889d8583b4ddd9f31180b0f7f6620ef6d050240f257ff96c4c0d0cf::artem {
    struct ARTEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARTEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARTEM>(arg0, 6, b"ARTEM", b"ARTEM", b"coin to the moooon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/Qme31MiTozmuadZbegQNq4X1fThLtcw7mPKzePjvdEFcSJ?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ARTEM>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARTEM>>(v2, @0xaca2a52083bd23b09cf8efe2c9b84903d04a46dba6c6f78b4ef06f8bbec1082);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARTEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

