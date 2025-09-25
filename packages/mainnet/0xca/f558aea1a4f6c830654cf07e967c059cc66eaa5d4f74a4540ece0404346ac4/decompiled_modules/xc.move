module 0xcaf558aea1a4f6c830654cf07e967c059cc66eaa5d4f74a4540ece0404346ac4::xc {
    struct XC has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<XC>, arg1: 0x2::coin::Coin<XC>) {
        0x2::coin::burn<XC>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<XC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<XC> {
        0x2::coin::mint<XC>(arg0, arg1, arg2)
    }

    fun init(arg0: XC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XC>(arg0, 6, b"XC", b"XXCC", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1758798107178kqfv.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XC>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<XC>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<XC> {
        assert!(0x2::coin::total_supply<XC>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<XC>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

