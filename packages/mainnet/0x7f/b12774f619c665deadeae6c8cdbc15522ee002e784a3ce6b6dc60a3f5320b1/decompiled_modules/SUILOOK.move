module 0x7fb12774f619c665deadeae6c8cdbc15522ee002e784a3ce6b6dc60a3f5320b1::SUILOOK {
    struct SUILOOK has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUILOOK>, arg1: 0x2::coin::Coin<SUILOOK>) {
        0x2::coin::burn<SUILOOK>(arg0, arg1);
    }

    fun init(arg0: SUILOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILOOK>(arg0, 9, b"SLOOK", b"Sui Look", b"Ryan Coin Demo Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/DgG5G6F/look.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILOOK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILOOK>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUILOOK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUILOOK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

