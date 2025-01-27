module 0xc4c8c53058b1dbe964505f2ba64c6398747fa30707668858358db6b200270f98::spepe {
    struct SPEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SPEPE>, arg1: 0x2::coin::Coin<SPEPE>) {
        0x2::coin::burn<SPEPE>(arg0, arg1);
    }

    fun init(arg0: SPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPEPE>(arg0, 2, b"SPEPE", b"SUI PEPE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sui-pepe.xyz/_next/static/media/logo.6e0d8f53.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPEPE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SPEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SPEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

