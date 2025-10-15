module 0xf3ef101ca7e74610680fac04e8ad12a9476e797ba2ba71dee2608068267d3f86::usdt {
    struct USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT>(arg0, 9, b"USDT", b"Tether USD", b"It is a stable coin backed by real USD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUMCx1hpZfKW5q7LwiXQpC2hjgR93Lc8kw2F5WyNoMVip")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<USDT>(&mut v2, 18446744073000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

