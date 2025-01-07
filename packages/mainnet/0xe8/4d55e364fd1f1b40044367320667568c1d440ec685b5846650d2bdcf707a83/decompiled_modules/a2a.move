module 0xe84d55e364fd1f1b40044367320667568c1d440ec685b5846650d2bdcf707a83::a2a {
    struct A2A has drop {
        dummy_field: bool,
    }

    fun init(arg0: A2A, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A2A>(arg0, 9, b"A2A", b"A2A", b"A2A is A2A's utility token, and by staking it, user get the opportunity to participate in IDO and INO. In addition, user can participate in the governance that determines the direction of the project by using the XUI Token. It can be used as currency in DEX and NFT Marketplace, and liquidity can be supplied along with YouXUI. On social platforms, it can be used when clicking likes or making donations. By staking XUI Tokens, user not only get staking rewards, but also become an early investor in cutting-edge and high-potential projects.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a2a.io/images/coins/a2a.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<A2A>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A2A>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A2A>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

