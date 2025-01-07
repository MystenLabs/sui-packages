module 0x32327c93f8c5f66d1b265eda6ef8f1ad7d389eb6565c74053d7de2ae4fe1ffc6::GDE {
    struct GDE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<GDE>, arg1: 0x2::coin::Coin<GDE>) {
        0x2::coin::burn<GDE>(arg0, arg1);
    }

    fun init(arg0: GDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDE>(arg0, 9, b"GDE", b"Golden Egg", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/103QyLT/golden.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GDE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GDE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<GDE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

