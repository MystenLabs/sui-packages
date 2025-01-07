module 0x1d325e3b7f4c75b77ca54e981f6481f1d41b7561d9f4b912b4963f415e9a2f5b::slg {
    struct SLG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLG>(arg0, 6, b"SLG", b"slim gaben", b"gaben lost weight for summer, everyone should do that too", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmWyUCGP4P49ZwiQKj8aQgHPnjr4pWk5b6gBYHatWDpBTZ?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SLG>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLG>>(v2, @0x90bda91c34b77957d5896eb9d0508b075da44c21b7614c50151def5fce164b86);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLG>>(v1);
    }

    // decompiled from Move bytecode v6
}

