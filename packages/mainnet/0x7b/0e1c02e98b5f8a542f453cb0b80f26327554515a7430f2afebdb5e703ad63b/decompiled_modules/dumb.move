module 0x7b0e1c02e98b5f8a542f453cb0b80f26327554515a7430f2afebdb5e703ad63b::dumb {
    struct DUMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUMB>(arg0, 6, b"DUMB", b"Dumb", b"dumb coin for dums", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/Qmf8SrNfGYEXpZxTzoXsqmUPzt2xVbqRmbSfZLB4kHsYsF?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DUMB>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUMB>>(v2, @0x124b46da1415d845ebf96eeeaf621660e43202bb665dc43c4c9edbbd7af9ef1c);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

