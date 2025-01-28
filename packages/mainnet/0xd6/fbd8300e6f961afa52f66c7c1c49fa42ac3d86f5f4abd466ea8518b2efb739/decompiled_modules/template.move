module 0xd6fbd8300e6f961afa52f66c7c1c49fa42ac3d86f5f4abd466ea8518b2efb739::template {
    struct TEMPLATE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEMPLATE>, arg1: 0x2::coin::Coin<TEMPLATE>) {
        0x2::coin::burn<TEMPLATE>(arg0, arg1);
    }

    fun init(arg0: TEMPLATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMPLATE>(arg0, 9, b"SYMBOL", b"NAME", b"DESCRIPTION", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEMPLATE>>(v1);
        0x2::coin::mint_and_transfer<TEMPLATE>(&mut v2, 7777, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMPLATE>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEMPLATE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEMPLATE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

