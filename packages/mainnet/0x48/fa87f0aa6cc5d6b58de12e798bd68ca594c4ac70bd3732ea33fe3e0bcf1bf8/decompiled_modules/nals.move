module 0x48fa87f0aa6cc5d6b58de12e798bd68ca594c4ac70bd3732ea33fe3e0bcf1bf8::nals {
    struct NALS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NALS>, arg1: 0x2::coin::Coin<NALS>) {
        0x2::coin::burn<NALS>(arg0, arg1);
    }

    public entry fun custom_burn(arg0: &mut 0x2::coin::TreasuryCap<NALS>, arg1: &mut 0x2::coin::Coin<NALS>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<NALS>(arg0, 0x2::coin::split<NALS>(arg1, arg2, arg3));
    }

    fun init(arg0: NALS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NALS>(arg0, 6, b"NALS", b"NALS", b"NALS Meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://s2.coinmarketcap.com/static/img/coins/64x64/25028.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NALS>(&mut v2, 314000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NALS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NALS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

