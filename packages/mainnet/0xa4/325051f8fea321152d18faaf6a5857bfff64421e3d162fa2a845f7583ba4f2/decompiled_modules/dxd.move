module 0xa4325051f8fea321152d18faaf6a5857bfff64421e3d162fa2a845f7583ba4f2::dxd {
    struct DXD has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<DXD>, arg1: 0x2::coin::Coin<DXD>) {
        0x2::coin::burn<DXD>(arg0, arg1);
    }

    fun init(arg0: DXD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DXD>(arg0, 9, b"DXD", b"DXD Labs", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DXD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DXD>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<DXD>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<DXD>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

