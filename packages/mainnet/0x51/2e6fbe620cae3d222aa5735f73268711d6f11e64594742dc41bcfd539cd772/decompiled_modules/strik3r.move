module 0x512e6fbe620cae3d222aa5735f73268711d6f11e64594742dc41bcfd539cd772::strik3r {
    struct STRIK3R has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<STRIK3R>, arg1: 0x2::coin::Coin<STRIK3R>) {
        0x2::coin::burn<STRIK3R>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<STRIK3R>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<STRIK3R>>(0x2::coin::mint<STRIK3R>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: STRIK3R, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRIK3R>(arg0, 9, b"STRK3R", b"STRIK3R Token", b"STRIK3R ecosystem token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strik3r.com")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRIK3R>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STRIK3R>>(v1);
    }

    // decompiled from Move bytecode v7
}

