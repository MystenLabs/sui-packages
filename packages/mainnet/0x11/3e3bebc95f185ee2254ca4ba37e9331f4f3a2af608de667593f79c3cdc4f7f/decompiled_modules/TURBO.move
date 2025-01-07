module 0x113e3bebc95f185ee2254ca4ba37e9331f4f3a2af608de667593f79c3cdc4f7f::TURBO {
    struct TURBO has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TURBO>, arg1: 0x2::coin::Coin<TURBO>) {
        0x2::coin::burn<TURBO>(arg0, arg1);
    }

    fun init(arg0: TURBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBO>(arg0, 2, b"Sui Turbo", b"Sui Turbo", b"Turbo on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.dextools.io/resources/tokens/logos/ether/0xa35923162c49cf95e6bf26623385eb431ad920d3.jpeg?1683326534337")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBO>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TURBO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TURBO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

