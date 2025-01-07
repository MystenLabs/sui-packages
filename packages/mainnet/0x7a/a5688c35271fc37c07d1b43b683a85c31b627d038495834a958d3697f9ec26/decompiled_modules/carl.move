module 0x7aa5688c35271fc37c07d1b43b683a85c31b627d038495834a958d3697f9ec26::carl {
    struct CARL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARL>(arg0, 6, b"CARL", b"CARL AND PEPE", b"Pepe and carl are friends and they are trying to help memechan. let's join us and make memechan great again!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmUoWkso464Q7ZUicDRWeKAhVYkscMsuud3u2LpzyzNhQz?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CARL>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARL>>(v2, @0x57a868aff9bbfe884ee873f54b83a4c0704963da8c53f3cd4154451c0991424c);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARL>>(v1);
    }

    // decompiled from Move bytecode v6
}

