module 0x8142dbb8b0759ac329de9963305d5aafa007dc2ec6e98be772ff654eee2e3936::dumptrump {
    struct DUMPTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMPTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMPTRUMP>(arg0, 6, b"DumpTrump", b"Dump Trump", b"lfg ths shit! dump trump save the crypto!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmdaER3foPLiTnL8MefUSHvcmxSUvCU9PkQU2dhymxV4AL?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DUMPTRUMP>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMPTRUMP>>(v2, @0xa5f7eec2820d986450e8bfb6de3fec117879dc443274cb1bec20215172d77524);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUMPTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

