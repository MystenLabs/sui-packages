module 0x37debb81f414fcd4713d6a792d9a9f9aebdf65e3199f76371c95ea2d74267726::taki {
    struct TAKI has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TAKI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TAKI>>(0x2::coin::mint<TAKI>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: TAKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAKI>(arg0, 9, b"TAKI", b"TAKI", b"Waterfall of sui aka as TAKI makes fall on the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1742358553846005760/LVo_T8Nc_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TAKI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAKI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

