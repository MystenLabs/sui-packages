module 0x9dff7c2730643af69881ba838462c08bc97e7b43ab4b9bf858a9178a83e05e31::MOON {
    struct MOON has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MOON>, arg1: 0x2::coin::Coin<MOON>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<MOON>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOON>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOON>>(0x2::coin::mint<MOON>(arg0, arg1, arg3), arg2);
    }

    public entry fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<MOON>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOON>>(arg0);
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON>(arg0, 9, b"MOON", b"suimoon", b"Sui Moon is the next Meme Coin to go to the MOON That also rewards its holders", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suirewards.me/coinphp/uploads/img_68be73cfe609b0.84569326.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

