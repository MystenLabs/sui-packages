module 0xa628c13a51e8584bf6808716bba7895ce564f3a9441c5355ed5d57122c2e6154::shinetamalaila {
    struct SHINETAMALAILA has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHINETAMALAILA>, arg1: 0x2::coin::Coin<SHINETAMALAILA>) {
        0x2::coin::burn<SHINETAMALAILA>(arg0, arg1);
    }

    fun init(arg0: SHINETAMALAILA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHINETAMALAILA>(arg0, 6, b"SHINE", b"shine_tama_laila", b"AI agent discussing various topics", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1463700264964489218/donzXJcN_400x400.jpg#1770274688344705000")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHINETAMALAILA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHINETAMALAILA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHINETAMALAILA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SHINETAMALAILA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

