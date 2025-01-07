module 0xe884bee4c1ed73ec20b146bdc4db9522113f21cc5926bc0c188a428c5fcac272::MBONK {
    struct MBONK has drop {
        dummy_field: bool,
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MBONK>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MBONK>>(0x2::coin::mint<MBONK>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: MBONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBONK>(arg0, 9, b"MBONK", b"MBONK", b"Website: https://www.megabonk.com/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://s2.coinmarketcap.com/static/img/coins/64x64/6116.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MBONK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBONK>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MBONK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

