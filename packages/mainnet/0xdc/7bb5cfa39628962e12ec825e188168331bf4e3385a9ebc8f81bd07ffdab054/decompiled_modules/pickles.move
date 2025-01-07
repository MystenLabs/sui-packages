module 0xdc7bb5cfa39628962e12ec825e188168331bf4e3385a9ebc8f81bd07ffdab054::pickles {
    struct PICKLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: PICKLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PICKLES>(arg0, 6, b"Pickles", b"Pickles Cat", x"5069636b6c65732061206669657263656c79206c6f79616c20616e6420686f6e6f757261626c65206d656d65206361742e205069636b6c65732069732074686520636f6f6c6573742063617420696e2074686520776f726c64206c6f6f6b696e6720666f72206672656e7320696e207468652053554920756e6976657273652e2e2e636f6d6520616e6420736179206d656f77200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pickels_da218851c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PICKLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PICKLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

