module 0x2e67b62bd53f6238738e3fca16342f1f18dba1a5fa20279cf2e8271a7b9e0b56::lilb {
    struct LILB has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILB>(arg0, 6, b"lilb", b"lilb", x"e99bb6e78fade5889be5a78be4baba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmPX7XzthSYCgHvCtX9hCpGTS48577omaLpmP1xNQsytPw?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LILB>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILB>>(v2, @0x990f0564a4eb21ddc375fcb8b28c6d9fad4e331495b681bcb202579ede269d5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LILB>>(v1);
    }

    // decompiled from Move bytecode v6
}

