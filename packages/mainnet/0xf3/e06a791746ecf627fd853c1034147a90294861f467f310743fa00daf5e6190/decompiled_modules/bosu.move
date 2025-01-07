module 0xf3e06a791746ecf627fd853c1034147a90294861f467f310743fa00daf5e6190::bosu {
    struct BOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSU>(arg0, 6, b"BOSU", b"BOOK OF SUI", x"4368617074657220313a205468652047656e65736973206f66204761696e730a2254686f75207368616c742061706520696e746f2070726f6a6563747320776974686f75742068657369746174696f6e2c20666f7220666f7274756e65206661766f72732074686520646567656e2e22", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rectangulo_1_370d70e160.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

