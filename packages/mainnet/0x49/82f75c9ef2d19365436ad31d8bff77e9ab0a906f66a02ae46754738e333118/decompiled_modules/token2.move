module 0x4982f75c9ef2d19365436ad31d8bff77e9ab0a906f66a02ae46754738e333118::token2 {
    struct TOKEN2 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TOKEN2>, arg1: 0x2::coin::Coin<TOKEN2>) {
        0x2::coin::burn<TOKEN2>(arg0, arg1);
    }

    fun init(arg0: TOKEN2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN2>(arg0, 9, b"tt", b"TT", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN2>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TOKEN2>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TOKEN2>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

