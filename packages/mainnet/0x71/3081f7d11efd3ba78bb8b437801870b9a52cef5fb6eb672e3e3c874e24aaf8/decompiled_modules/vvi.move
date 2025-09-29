module 0x713081f7d11efd3ba78bb8b437801870b9a52cef5fb6eb672e3e3c874e24aaf8::vvi {
    struct VVI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<VVI>, arg1: 0x2::coin::Coin<VVI>) {
        0x2::coin::burn<VVI>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<VVI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VVI> {
        0x2::coin::mint<VVI>(arg0, arg1, arg2)
    }

    fun init(arg0: VVI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VVI>(arg0, 6, b"VVI", b"VV", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1759107288734B1Dd.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VVI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VVI>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<VVI>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<VVI> {
        assert!(0x2::coin::total_supply<VVI>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<VVI>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

