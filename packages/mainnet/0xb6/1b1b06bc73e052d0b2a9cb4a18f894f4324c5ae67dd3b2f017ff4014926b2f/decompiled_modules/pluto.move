module 0xb61b1b06bc73e052d0b2a9cb4a18f894f4324c5ae67dd3b2f017ff4014926b2f::pluto {
    struct PLUTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUTO>(arg0, 9, b"PLUTO", b"Pluto on Sui", x"796f2c2072656d656d6265722074686174207269636b2026206d6f72747920657069736f6465207768657265206a6572727920776f756c646ee28099742073746f70206669676874696e6720666f7220706c75746fe280997320706c616e6574207374617475733f576562736974653a68747470733a2f2f706c75746f746f6b656e6f6e7375692e66756e207c2054473a2068747470733a2f2f742e6d652f506c75746f4f6e537569207c20583a2068747470733a2f2f782e636f6d2f506c75746f5f4f6e5f537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.plutotokenonsui.fun/images/logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PLUTO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUTO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLUTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

