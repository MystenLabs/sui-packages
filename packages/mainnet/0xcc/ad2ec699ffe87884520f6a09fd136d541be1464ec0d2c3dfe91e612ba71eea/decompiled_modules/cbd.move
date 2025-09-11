module 0xccad2ec699ffe87884520f6a09fd136d541be1464ec0d2c3dfe91e612ba71eea::cbd {
    struct CBD has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CBD>, arg1: 0x2::coin::Coin<CBD>) {
        0x2::coin::burn<CBD>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<CBD>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CBD> {
        0x2::coin::mint<CBD>(arg0, arg1, arg2)
    }

    fun init(arg0: CBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CBD>(arg0, 6, b"CBD", b"CBDc", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/17575744138085xKc.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CBD>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<CBD>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CBD> {
        assert!(0x2::coin::total_supply<CBD>(arg0) + 1000000000000000 <= 1000000000000000, 0);
        0x2::coin::mint<CBD>(arg0, 1000000000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

