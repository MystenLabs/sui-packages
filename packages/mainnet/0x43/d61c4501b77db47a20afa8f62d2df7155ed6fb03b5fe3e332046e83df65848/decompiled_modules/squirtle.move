module 0x43d61c4501b77db47a20afa8f62d2df7155ed6fb03b5fe3e332046e83df65848::squirtle {
    struct SQUIRTLE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SQUIRTLE>, arg1: 0x2::coin::Coin<SQUIRTLE>) {
        0x2::coin::burn<SQUIRTLE>(arg0, arg1);
    }

    fun init(arg0: SQUIRTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRTLE>(arg0, 2, b"SQUI", b"SQUIRTLE", b"Bring some fun to sui, with the new pokemon series, squirtle, squish squish.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.imagebam.com/view/MERN2F4")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQUIRTLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRTLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SQUIRTLE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SQUIRTLE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

