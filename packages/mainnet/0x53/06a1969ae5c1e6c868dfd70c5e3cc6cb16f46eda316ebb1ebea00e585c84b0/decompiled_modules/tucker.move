module 0x5306a1969ae5c1e6c868dfd70c5e3cc6cb16f46eda316ebb1ebea00e585c84b0::tucker {
    struct TUCKER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUCKER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUCKER>(arg0, 9, b"TUCKER", b"Chris Tucker", b"Coin representing the actor Chris Tucker", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://scontent-lga3-2.xx.fbcdn.net/v/t39.30808-6/366344520_845483430276245_972504808508314204_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=nGYlJfdvLbEQ7kNvgHSIs8H&_nc_zt=23&_nc_ht=scontent-lga3-2.xx&_nc_gid=A8lfBdgS1OAMxyqw5XUZPOy&oh=00_AYBU6Zliy5bB6gw2xhiPq3V7i9hYOMjlR0vA7BepQvq2Dg&oe=67918ADB")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TUCKER>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUCKER>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUCKER>>(v1);
    }

    // decompiled from Move bytecode v6
}

