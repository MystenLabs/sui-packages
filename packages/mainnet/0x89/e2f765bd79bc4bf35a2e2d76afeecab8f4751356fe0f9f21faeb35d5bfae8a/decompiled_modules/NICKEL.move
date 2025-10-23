module 0x89e2f765bd79bc4bf35a2e2d76afeecab8f4751356fe0f9f21faeb35d5bfae8a::NICKEL {
    struct NICKEL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NICKEL>, arg1: 0x2::coin::Coin<NICKEL>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<NICKEL>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NICKEL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NICKEL>>(0x2::coin::mint<NICKEL>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<NICKEL>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NICKEL>>(arg0);
    }

    fun init(arg0: NICKEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NICKEL>(arg0, 9, b"NICKEL", b"Nickelcoin", b"Is $250,000 worth of nickels enough to retire?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suirewards.me/coinphp/uploads/img_68f9962da67ef3.99741509.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NICKEL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NICKEL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

