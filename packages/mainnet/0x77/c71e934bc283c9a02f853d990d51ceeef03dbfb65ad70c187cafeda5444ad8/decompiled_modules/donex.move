module 0x77c71e934bc283c9a02f853d990d51ceeef03dbfb65ad70c187cafeda5444ad8::donex {
    struct DONEX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DONEX>, arg1: 0x2::coin::Coin<DONEX>) {
        0x2::coin::burn<DONEX>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DONEX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DONEX>>(0x2::coin::mint<DONEX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DONEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONEX>(arg0, 9, b"donex", b"DONEX", b"test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONEX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONEX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

