module 0x32c787c3f7b889b7eec0f92a2654df58795fc3a5aa31747ce715454ba630fcdf::suipepe {
    struct SUIPEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUIPEPE>, arg1: 0x2::coin::Coin<SUIPEPE>) {
        0x2::coin::burn<SUIPEPE>(arg0, arg1);
    }

    public entry fun give_up_permission(arg0: 0x2::coin::TreasuryCap<SUIPEPE>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEPE>>(arg0, 0x2::address::from_u256(0));
    }

    fun init(arg0: SUIPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPEPE>(arg0, 2, b"Sui Pepe", b"Sui Pepe", b"sui pepe is the first ecosystem focused meme coin on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sui-pepe.xyz/_next/static/media/logo.6e0d8f53.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUIPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

