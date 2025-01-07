module 0x4baaeb6b4f64c7b989f22781309cd9b31fc1b1b3e44395c8b435027d79ef1b14::rzx_token {
    struct RZX_TOKEN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<RZX_TOKEN>, arg1: 0x2::coin::Coin<RZX_TOKEN>) {
        0x2::coin::burn<RZX_TOKEN>(arg0, arg1);
    }

    fun init(arg0: RZX_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RZX_TOKEN>(arg0, 2, b"RZX-sym", b"RZX-name", b"RZX-desp", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RZX_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RZX_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RZX_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<RZX_TOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

