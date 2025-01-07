module 0xda5d8e698264f655cc2146634376de45ce571fbb940e4c9a6e1bc0710077cae2::waye {
    struct WAYE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WAYE>, arg1: 0x2::coin::Coin<WAYE>) {
        0x2::coin::burn<WAYE>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WAYE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<WAYE>(arg0) + arg1 <= 1000000000000000000, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<WAYE>>(0x2::coin::mint<WAYE>(arg0, arg1, arg3), arg2);
    }

    public fun get_current_supply(arg0: &0x2::coin::TreasuryCap<WAYE>) : u64 {
        0x2::coin::total_supply<WAYE>(arg0)
    }

    fun init(arg0: WAYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAYE>(arg0, 9, b"WAYE", b"Waye Token", b"Waye Token is a utility token for the Swaye Ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://waye-sui-bucket.s3.eu-west-1.amazonaws.com/waye_logo.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

