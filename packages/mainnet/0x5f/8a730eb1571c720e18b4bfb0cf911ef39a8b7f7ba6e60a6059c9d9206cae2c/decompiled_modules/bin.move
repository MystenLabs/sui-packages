module 0x5f8a730eb1571c720e18b4bfb0cf911ef39a8b7f7ba6e60a6059c9d9206cae2c::bin {
    struct BIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BIN>, arg1: 0x2::coin::Coin<BIN>) {
        0x2::coin::burn<BIN>(arg0, arg1);
    }

    fun init(arg0: BIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIN>(arg0, 6, b"BON", b"BIN", b"The official binx token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fZpgjr7.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

