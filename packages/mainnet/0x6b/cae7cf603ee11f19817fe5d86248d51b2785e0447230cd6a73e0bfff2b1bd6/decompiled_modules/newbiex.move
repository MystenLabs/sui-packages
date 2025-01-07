module 0x6bcae7cf603ee11f19817fe5d86248d51b2785e0447230cd6a73e0bfff2b1bd6::newbiex {
    struct NEWBIEX has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<NEWBIEX>, arg1: 0x2::coin::Coin<NEWBIEX>) {
        0x2::coin::burn<NEWBIEX>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NEWBIEX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NEWBIEX>>(0x2::coin::mint<NEWBIEX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NEWBIEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEWBIEX>(arg0, 9, b"newbiex", b"NEWBIEX", b"test newbiexxx", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEWBIEX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEWBIEX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

