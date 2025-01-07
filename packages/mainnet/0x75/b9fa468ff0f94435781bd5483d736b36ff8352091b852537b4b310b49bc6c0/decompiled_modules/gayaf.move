module 0x75b9fa468ff0f94435781bd5483d736b36ff8352091b852537b4b310b49bc6c0::gayaf {
    struct GAYAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAYAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAYAF>(arg0, 6, b"GayAF", b"GayAF", b"introducing $gayaf, the fabulous new cryptocurrency from gay sui labs! ready to slay the financial world with a dash of glitter and a whole lot of sparkle, $gayaf is here to make your portfolio as fabulous as your gay inner self.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmRD7FgCjVFxCGMbD3E3QGy6nGaUCE6MqnmwENyUa2UCjF?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GAYAF>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAYAF>>(v2, @0xb16634105cc63be699ae0de6d283db0c200dfc29c645aefdb0108718bf1ea4b1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAYAF>>(v1);
    }

    // decompiled from Move bytecode v6
}

