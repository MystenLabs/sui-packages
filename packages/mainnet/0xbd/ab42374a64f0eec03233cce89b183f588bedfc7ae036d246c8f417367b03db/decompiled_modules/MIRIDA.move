module 0xbdab42374a64f0eec03233cce89b183f588bedfc7ae036d246c8f417367b03db::MIRIDA {
    struct MIRIDA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<MIRIDA>, arg1: 0x2::coin::Coin<MIRIDA>) {
        0x2::coin::burn<MIRIDA>(arg0, arg1);
    }

    fun init(arg0: MIRIDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIRIDA>(arg0, 9, b"MIRIDA", b"MIRIDA", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIRIDA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIRIDA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MIRIDA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MIRIDA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

