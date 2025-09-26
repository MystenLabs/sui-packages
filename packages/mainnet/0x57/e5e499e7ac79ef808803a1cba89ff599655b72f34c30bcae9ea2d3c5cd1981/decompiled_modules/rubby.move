module 0x57e5e499e7ac79ef808803a1cba89ff599655b72f34c30bcae9ea2d3c5cd1981::rubby {
    struct RUBBY has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<RUBBY>, arg1: 0x2::coin::Coin<RUBBY>) {
        0x2::coin::burn<RUBBY>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<RUBBY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<RUBBY> {
        0x2::coin::mint<RUBBY>(arg0, arg1, arg2)
    }

    fun init(arg0: RUBBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUBBY>(arg0, 6, b"RUBBY", b"rubbb", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1758869607351Q84K.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUBBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUBBY>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<RUBBY>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<RUBBY> {
        assert!(0x2::coin::total_supply<RUBBY>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<RUBBY>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

