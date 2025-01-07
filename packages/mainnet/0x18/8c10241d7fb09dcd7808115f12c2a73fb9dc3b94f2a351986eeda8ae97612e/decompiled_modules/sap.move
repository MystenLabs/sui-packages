module 0x188c10241d7fb09dcd7808115f12c2a73fb9dc3b94f2a351986eeda8ae97612e::sap {
    struct SAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAP>(arg0, 6, b"SAP", b"SAPCAT", b"SAP CAT MEANS WHATS UP ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/giphy_3748551191_4ef92f2044.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

