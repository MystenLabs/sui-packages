module 0x1e993e6079b37d5f42c9d1ed37b7f32f8cbabc65d40d53055ead7b1afa728d27::johnson8 {
    struct JOHNSON8 has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<JOHNSON8>, arg1: 0x2::coin::Coin<JOHNSON8>) {
        0x2::coin::burn<JOHNSON8>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<JOHNSON8>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JOHNSON8> {
        0x2::coin::mint<JOHNSON8>(arg0, arg1, arg2)
    }

    fun init(arg0: JOHNSON8, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOHNSON8>(arg0, 6, b"JOHNSON8", b"johnson8", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1759078107518lk9f.jpeg"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOHNSON8>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOHNSON8>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<JOHNSON8>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JOHNSON8> {
        assert!(0x2::coin::total_supply<JOHNSON8>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<JOHNSON8>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

