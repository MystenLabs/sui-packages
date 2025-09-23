module 0x9fc1ae7c49a2456e219a17502c51a2c76eaa0cf6211d2cf17c53829191d59603::lo01s {
    struct LO01S has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LO01S>, arg1: 0x2::coin::Coin<LO01S>) {
        0x2::coin::burn<LO01S>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<LO01S>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LO01S> {
        0x2::coin::mint<LO01S>(arg0, arg1, arg2)
    }

    fun init(arg0: LO01S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LO01S>(arg0, 6, b"LO01S", b"LO01", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1758626140972dUAr.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LO01S>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LO01S>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<LO01S>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LO01S> {
        assert!(0x2::coin::total_supply<LO01S>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<LO01S>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

