module 0x44e9814e6006a1efc2798f1f8cc46a7ac689cbd33ac97942f434c24bd9f42bb8::jj {
    struct JJ has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<JJ>, arg1: 0x2::coin::Coin<JJ>) {
        0x2::coin::burn<JJ>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<JJ>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JJ> {
        0x2::coin::mint<JJ>(arg0, arg1, arg2)
    }

    fun init(arg0: JJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JJ>(arg0, 6, b"JJ", b"JJ6", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1761914908590avdn.jpeg"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JJ>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<JJ>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JJ> {
        assert!(0x2::coin::total_supply<JJ>(arg0) + 1000000000000000 <= 1000000000000000, 0);
        0x2::coin::mint<JJ>(arg0, 1000000000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

