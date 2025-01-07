module 0xe1fea9480234dff6b06b890c75af718c8aff685bc982406e6563d8bff207d713::wakeup {
    struct WAKEUP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<WAKEUP>, arg1: 0x2::coin::Coin<WAKEUP>) {
        0x2::coin::burn<WAKEUP>(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WAKEUP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WAKEUP>>(0x2::coin::mint<WAKEUP>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: WAKEUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAKEUP>(arg0, 9, b"wakeup", b"WAKEUP", b"test token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAKEUP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAKEUP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

