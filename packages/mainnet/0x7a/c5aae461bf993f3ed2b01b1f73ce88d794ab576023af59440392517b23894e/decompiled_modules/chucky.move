module 0x7ac5aae461bf993f3ed2b01b1f73ce88d794ab576023af59440392517b23894e::chucky {
    struct CHUCKY has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CHUCKY>, arg1: 0x2::coin::Coin<CHUCKY>) {
        0x2::coin::burn<CHUCKY>(arg0, arg1);
    }

    fun init(arg0: CHUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUCKY>(arg0, 6, b"CHUCKY", b"Chucky Doll", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/mHDJSjM/chucky.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHUCKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUCKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHUCKY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CHUCKY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

