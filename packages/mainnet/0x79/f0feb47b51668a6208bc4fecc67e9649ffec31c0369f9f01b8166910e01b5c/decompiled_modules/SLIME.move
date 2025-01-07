module 0x79f0feb47b51668a6208bc4fecc67e9649ffec31c0369f9f01b8166910e01b5c::SLIME {
    struct SLIME has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SLIME>, arg1: 0x2::coin::Coin<SLIME>) {
        0x2::coin::burn<SLIME>(arg0, arg1);
    }

    fun init(arg0: SLIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIME>(arg0, 9, b"SSM", b"Slime Smile", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/ZSsbDkn/slime.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLIME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIME>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SLIME>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SLIME>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

