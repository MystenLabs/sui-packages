module 0x54f3bd53cb82492d4879db2bb8de7097def2aa3ee8d283513ac6a947571d679a::johnson {
    struct JOHNSON has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<JOHNSON>, arg1: 0x2::coin::Coin<JOHNSON>) {
        0x2::coin::burn<JOHNSON>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<JOHNSON>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JOHNSON> {
        0x2::coin::mint<JOHNSON>(arg0, arg1, arg2)
    }

    fun init(arg0: JOHNSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOHNSON>(arg0, 6, b"JOHNSON", b"johnson", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1758546119796Pp7z.jpeg"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOHNSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOHNSON>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<JOHNSON>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JOHNSON> {
        assert!(0x2::coin::total_supply<JOHNSON>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<JOHNSON>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

