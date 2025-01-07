module 0x565a656ec545eff09f4ccfbd7e7c1765ec68fbc957d8515f7dd22b1c2b0928b1::DUCK {
    struct DUCK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DUCK>, arg1: 0x2::coin::Coin<DUCK>) {
        0x2::coin::burn<DUCK>(arg0, arg1);
    }

    fun init(arg0: DUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCK>(arg0, 9, b"DUCK", b"Duck Sui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/q5QTmS1/ducksui.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DUCK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DUCK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

