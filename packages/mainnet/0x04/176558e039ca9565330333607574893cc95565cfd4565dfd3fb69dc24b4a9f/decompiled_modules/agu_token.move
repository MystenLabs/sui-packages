module 0x4176558e039ca9565330333607574893cc95565cfd4565dfd3fb69dc24b4a9f::agu_token {
    struct AGU_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<AGU_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<AGU_TOKEN>(arg0) + arg1 <= 1000000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<AGU_TOKEN>>(0x2::coin::mint<AGU_TOKEN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: AGU_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGU_TOKEN>(arg0, 6, b"XAUT", b"XAUT", b"XAUT Token on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://icon.suntool.cc/file/tether-gold.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<AGU_TOKEN>>(0x2::coin::mint<AGU_TOKEN>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGU_TOKEN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AGU_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

