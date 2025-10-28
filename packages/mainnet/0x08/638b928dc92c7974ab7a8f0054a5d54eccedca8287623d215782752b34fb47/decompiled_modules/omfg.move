module 0x8638b928dc92c7974ab7a8f0054a5d54eccedca8287623d215782752b34fb47::omfg {
    struct OMFG has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<OMFG>, arg1: 0x2::coin::Coin<OMFG>) {
        0x2::coin::burn<OMFG>(arg0, arg1);
    }

    fun init(arg0: OMFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OMFG>(arg0, 9, b"omfg", b"OMFG", b"OMFG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gocoin.one/uploads/logo_1761635427320_80654b02.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OMFG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OMFG>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<OMFG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<OMFG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

