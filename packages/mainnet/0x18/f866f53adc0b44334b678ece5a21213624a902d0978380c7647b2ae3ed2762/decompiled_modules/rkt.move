module 0x18f866f53adc0b44334b678ece5a21213624a902d0978380c7647b2ae3ed2762::rkt {
    struct RKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RKT>(arg0, 6, b"RKT", b"Roaring Kitty", b"KITTY ABOUT TO ROAR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmQwqz5ZHWX88gjCU2Heb86zmv6BisLRQSch8yVKARpxXp?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RKT>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RKT>>(v2, @0x88f2b44b8caf0cae6362d039670f3b9a1385f2180b383965b558eb72c86ca499);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

