module 0x8ce82da8aad6cbe9c1f7b1eecbfb2ae9d6bffce219053e10f421f26bf1e010e5::eww {
    struct EWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: EWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EWW>(arg0, 6, b"EWW", b"EWW WHATS THAT BROTHER", b"someone hears a strange noise in the house and goes, \"what's that, brother?\" with a mix of curiosity and slight panic, while holding a spatula like a weapon ready to confront the unknown.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmQmw5S7HPt1NC9wVviCMWDNz2aR8t2Kd5k3qnsEHGwZXc?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EWW>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EWW>>(v2, @0x1b62b76c353a3e52fa870aa5e52162ebbbdce3baa1266df8350095e67acd36a7);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EWW>>(v1);
    }

    // decompiled from Move bytecode v6
}

