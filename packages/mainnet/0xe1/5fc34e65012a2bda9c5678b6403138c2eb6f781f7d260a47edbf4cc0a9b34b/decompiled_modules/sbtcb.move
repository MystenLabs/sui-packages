module 0xe15fc34e65012a2bda9c5678b6403138c2eb6f781f7d260a47edbf4cc0a9b34b::sbtcb {
    struct SBTCB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBTCB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBTCB>(arg0, 6, b"sBTCB", b"sBaTCraB", x"4372616220636f696e200a696e20746865207761746572207765206c6976652c206f6e20746865206c616e642077652070726f73706572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmbydgzfDVoCnoj2T5KayS7PtGJrRwutL6tQGvV6P1jXMS?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SBTCB>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBTCB>>(v2, @0xaefe9f5825d1ad6b9f65f2ade3677c75dcf8035a416ca6b9a9dbc19465463bd5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBTCB>>(v1);
    }

    // decompiled from Move bytecode v6
}

