module 0x70e52f72f527e1b0ca41dc8d81d4765c05f7302dd56a9734037c4920f42ff331::kolins_agency_token {
    struct KOLINS_AGENCY_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<KOLINS_AGENCY_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<KOLINS_AGENCY_TOKEN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: KOLINS_AGENCY_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 679 || 0x2::tx_context::epoch(arg1) == 680, 1);
        let (v0, v1) = 0x2::coin::create_currency<KOLINS_AGENCY_TOKEN>(arg0, 9, b"KAT", b"KOLINS AGENCY TOKEN", x"496e6e6f776163796a6e6520726f7a7769c4857a616e69612070c58261746e69637a6520646c61204167656e636a69205072616379206f72617a20507261636f64617763c3b3772e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreiaztck4deuxmqec6y2yq2rst25g4mvexwemsdqgp63ydlbrsepwhy.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KOLINS_AGENCY_TOKEN>(&mut v2, 10000000000000000, @0x2408637d3485cf77a4e7cac51a4052fb2881d44202c27135b62a106e0fed1f9e, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOLINS_AGENCY_TOKEN>>(v2, @0x2408637d3485cf77a4e7cac51a4052fb2881d44202c27135b62a106e0fed1f9e);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOLINS_AGENCY_TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

