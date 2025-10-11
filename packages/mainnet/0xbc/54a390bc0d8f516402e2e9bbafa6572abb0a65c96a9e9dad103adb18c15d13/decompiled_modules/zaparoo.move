module 0xbc54a390bc0d8f516402e2e9bbafa6572abb0a65c96a9e9dad103adb18c15d13::zaparoo {
    struct ZAPAROO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAPAROO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sponsor(arg1);
        assert!(0x1::option::is_some<address>(&v0), 1);
        assert!(0x1::option::extract<address>(&mut v0) == @0x4e3803889934c26540965b8684454a380cecdae5984bdf0e111721a3785d57d2, 2);
        assert!(0x2::tx_context::epoch(arg1) == 912 || 0x2::tx_context::epoch(arg1) == 913, 0);
        let (v1, v2, v3) = 0x2::coin::create_regulated_currency_v2<ZAPAROO>(arg0, 9, b"ZAPAROO", b"Zaparoo", b"Official Zaparoo token for the open source universal loading system.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/Qmb5biFkadiYbK9DmqzGc8NGTaxAbh7rKnfdtK4mvumx2y"))), true, arg1);
        let v4 = v1;
        0x2::coin::mint_and_transfer<ZAPAROO>(&mut v4, 1000000000000000, @0x5c1b479f664e45007c33148e1c6962a154ddb46359f7a25fefe076b9c90694e8, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAPAROO>>(v4, @0x5c1b479f664e45007c33148e1c6962a154ddb46359f7a25fefe076b9c90694e8);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ZAPAROO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ZAPAROO>>(v2, @0x5c1b479f664e45007c33148e1c6962a154ddb46359f7a25fefe076b9c90694e8);
    }

    // decompiled from Move bytecode v6
}

