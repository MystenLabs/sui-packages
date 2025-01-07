module 0x5d5d0498a2066d942aded2eaada9621c1b906d34934dff43a1bbb8439880f372::x {
    struct X has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<X>, arg1: 0x2::coin::Coin<X>) {
        0x2::coin::burn<X>(arg0, arg1);
    }

    public entry fun custom_burn(arg0: &mut 0x2::coin::TreasuryCap<X>, arg1: &mut 0x2::coin::Coin<X>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<X>(arg0, 0x2::coin::split<X>(arg1, arg2, arg3));
    }

    fun init(arg0: X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<X>(arg0, 6, b"X", b"xAI Token", b"xAI Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1683325380441128960/yRsRRjGO_400x400.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<X>(&mut v2, 500000000000000000, @0xffed1e3a3b44c55d8a1300bf9ad7abb11825d45e66ab4bcadb5f7b5f4bce7d3a, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<X>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<X>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

