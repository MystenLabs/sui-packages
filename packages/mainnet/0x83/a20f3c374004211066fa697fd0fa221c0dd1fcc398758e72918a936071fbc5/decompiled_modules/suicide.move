module 0x83a20f3c374004211066fa697fd0fa221c0dd1fcc398758e72918a936071fbc5::suicide {
    struct SUICIDE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUICIDE>, arg1: 0x2::coin::Coin<SUICIDE>) {
        0x2::coin::burn<SUICIDE>(arg0, arg1);
    }

    fun init(arg0: SUICIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICIDE>(arg0, 2, b"SC", b"SUICIDE", b"DEAD", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUICIDE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICIDE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUICIDE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUICIDE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

