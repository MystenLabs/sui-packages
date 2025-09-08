module 0xb83b276a321b7e0a32b1026fbf38f824382dc9eda5662b528ac1d0e9c5718950::MARS {
    struct MARS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MARS>, arg1: 0x2::coin::Coin<MARS>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<MARS>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MARS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MARS>>(0x2::coin::mint<MARS>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<MARS>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MARS>>(arg0);
    }

    fun init(arg0: MARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARS>(arg0, 9, b"MARS", b"Marsonsui", b"Instead of shooting for the moon How about we Shoot for MARS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suirewards.me/coinphp/uploads/img_68bec18ac30961.60412131.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

