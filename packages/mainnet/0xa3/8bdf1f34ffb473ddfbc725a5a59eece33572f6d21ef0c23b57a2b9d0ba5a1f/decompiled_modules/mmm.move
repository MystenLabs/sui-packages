module 0xa38bdf1f34ffb473ddfbc725a5a59eece33572f6d21ef0c23b57a2b9d0ba5a1f::mmm {
    struct MMM has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<MMM>, arg1: 0x2::coin::Coin<MMM>) {
        0x2::coin::burn<MMM>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<MMM>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MMM> {
        0x2::coin::mint<MMM>(arg0, arg1, arg2)
    }

    fun init(arg0: MMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMM>(arg0, 6, b"MMM", b"pm", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1758869722416F8uh.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMM>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<MMM>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<MMM> {
        assert!(0x2::coin::total_supply<MMM>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<MMM>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

