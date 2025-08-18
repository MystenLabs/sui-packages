module 0x9b0928e5913fd4a7d723615bf43d54de2caf535e5df9f2e8083437e1bb2453f9::JIE {
    struct JIE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<JIE>, arg1: 0x2::coin::Coin<JIE>) {
        0x2::coin::burn<JIE>(arg0, arg1);
    }

    fun init(arg0: JIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JIE>(arg0, 9, b"JIE", b"JIE Test", b"My personal test coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JIE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JIE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

