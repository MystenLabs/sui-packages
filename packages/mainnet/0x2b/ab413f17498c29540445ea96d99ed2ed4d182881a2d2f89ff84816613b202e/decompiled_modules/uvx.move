module 0x2bab413f17498c29540445ea96d99ed2ed4d182881a2d2f89ff84816613b202e::uvx {
    struct UVX has drop {
        dummy_field: bool,
    }

    fun init(arg0: UVX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sponsor(arg1);
        assert!(0x1::option::is_some<address>(&v0), 1);
        assert!(0x1::option::extract<address>(&mut v0) == @0x4e3803889934c26540965b8684454a380cecdae5984bdf0e111721a3785d57d2, 2);
        assert!(0x2::tx_context::epoch(arg1) == 928 || 0x2::tx_context::epoch(arg1) == 929, 0);
        let (v1, v2) = 0x2::coin::create_currency<UVX>(arg0, 3, b"AWAX", b"AWAX Valuetion", b"its the space and earth research dependant services and discoveries attested with more than 60 books on amazon , www.amazon.com/author/amrfawzy. , and more than  54 researches about different universe dimensionshttps://www.researchgate.net/profile/Amr-Fawzy-4.  with new AI application for goodwill valuation of intengable assets www.awa-audit.com6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/Qmc79sFmZHdMEujUkRg3eHF51znSnbS4mM2B6A3rr5wfvh"))), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<UVX>(&mut v3, 9999999999000, @0xab6e24e8d81dc666055a9b91bd5b9e1b4220ebecfdcf8743b119355384229140, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UVX>>(v3, @0xab6e24e8d81dc666055a9b91bd5b9e1b4220ebecfdcf8743b119355384229140);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UVX>>(v2);
    }

    // decompiled from Move bytecode v6
}

