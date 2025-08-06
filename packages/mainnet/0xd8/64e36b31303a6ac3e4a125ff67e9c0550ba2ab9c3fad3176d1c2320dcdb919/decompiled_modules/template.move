module 0xd864e36b31303a6ac3e4a125ff67e9c0550ba2ab9c3fad3176d1c2320dcdb919::template {
    struct TEMPLATE has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEMPLATE>, arg1: 0x2::coin::Coin<TEMPLATE>) {
        0x2::coin::burn<TEMPLATE>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEMPLATE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TEMPLATE> {
        0x2::coin::mint<TEMPLATE>(arg0, arg1, arg2)
    }

    fun init(arg0: TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMPLATE>(arg0, 6, b"TMPL", b"Template Coin", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://example.com/icon.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMPLATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEMPLATE>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<TEMPLATE>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TEMPLATE> {
        assert!(0x2::coin::total_supply<TEMPLATE>(arg0) + 1000000000 <= 1000000000, 0);
        0x2::coin::mint<TEMPLATE>(arg0, 1000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

