module 0x7eab695f39e72d87076ea31c486ff72c60fba90a50d3d93368265cb3b024318e::NOBISUI {
    struct NOBISUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NOBISUI>, arg1: 0x2::coin::Coin<NOBISUI>) {
        0x2::coin::burn<NOBISUI>(arg0, arg1);
    }

    fun init(arg0: NOBISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOBISUI>(arg0, 9, b"NOBISUI", b"NOBISUIsui", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1751798044255989760/DWTuwMVB_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOBISUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOBISUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NOBISUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NOBISUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

