module 0xedeb906bb8cbaaf077b27b29c547d44c79959dadfdb39a64b109a13c53eefcc0::GONI {
    struct GONI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GONI>, arg1: 0x2::coin::Coin<GONI>) {
        0x2::coin::burn<GONI>(arg0, arg1);
    }

    fun init(arg0: GONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GONI>(arg0, 9, b"GONI", b"GONI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/CBQ7R6J/goni.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GONI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GONI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GONI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GONI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

