module 0x7ab99d649004037443b5b10621f6d885fad6433be4a098ec6a0da3e7f58a770a::pppp {
    struct PPPP has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<PPPP>, arg1: 0x2::coin::Coin<PPPP>) {
        0x2::coin::burn<PPPP>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<PPPP>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PPPP> {
        0x2::coin::mint<PPPP>(arg0, arg1, arg2)
    }

    fun init(arg0: PPPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPPP>(arg0, 6, b"PPPP", b"oo", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1755070262501nOch.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PPPP>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<PPPP>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<PPPP> {
        assert!(0x2::coin::total_supply<PPPP>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<PPPP>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

