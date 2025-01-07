module 0xe604450f01134861a23b62809b60c9649f3309a2067e67c8141f1027af5ba18e::evanai {
    struct EVANAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EVANAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EVANAI>(arg0, 9, b"EVANAI", b"AI EVAN", x"4e6f7420796f75722061766572616765206d656d65636f696e2c20244556414e414920656d626f646965732074686520737069726974206f6620537569277320636f2d666f756e6465723a206275696c64696e67206f76657220687970652c207375627374616e6365206f7665722073706563756c6174696f6e2e20546869732069736e2774206a75737420616e6f7468657220746f6b656e20e28093206974277320612073746174656d656e742061626f757420776861742063727970746f2063756c747572652073686f756c642062652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/flgAosw.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EVANAI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EVANAI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EVANAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

