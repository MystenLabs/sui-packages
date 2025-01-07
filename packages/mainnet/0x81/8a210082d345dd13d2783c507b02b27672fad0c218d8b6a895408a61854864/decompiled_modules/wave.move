module 0x818a210082d345dd13d2783c507b02b27672fad0c218d8b6a895408a61854864::wave {
    struct WAVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVE>(arg0, 6, b"Wave", b"Sui Wave", b"Surrender to the waves of Sui in the summer heat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmPSDvRpYR7JdS7GrBQQ6XYm4zF7AePondmA8WeCq3mYzg?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WAVE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAVE>>(v2, @0x7d4256f4469425f5d76131f887b4225b3c7cc4493a7fab8116aee861fb2eb0f4);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

