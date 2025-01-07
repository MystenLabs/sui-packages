module 0xfb8a33b35f4d6f6957e97c250d3c2d6ae3641aa9d2d29387264d0e53e3304e4d::apt {
    struct APT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<APT>, arg1: 0x2::coin::Coin<APT>) {
        0x2::coin::burn<APT>(arg0, arg1);
    }

    public entry fun custom_burn(arg0: &mut 0x2::coin::TreasuryCap<APT>, arg1: &mut 0x2::coin::Coin<APT>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<APT>(arg0, 0x2::coin::split<APT>(arg1, arg2, arg3));
    }

    fun init(arg0: APT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APT>(arg0, 6, b"APT", b"APT", b"APT Meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://s2.coinmarketcap.com/static/img/coins/64x64/21794.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<APT>(&mut v2, 314000000000000000, @0xffed1e3a3b44c55d8a1300bf9ad7abb11825d45e66ab4bcadb5f7b5f4bce7d3a, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

