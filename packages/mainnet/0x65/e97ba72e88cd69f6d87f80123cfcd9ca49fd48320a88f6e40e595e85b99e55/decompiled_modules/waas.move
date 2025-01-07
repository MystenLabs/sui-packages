module 0x65e97ba72e88cd69f6d87f80123cfcd9ca49fd48320a88f6e40e595e85b99e55::waas {
    struct WAAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAAS>(arg0, 6, b"WAAS", b"WE ARE ALL SATOSHI", x"496620796f7527726520736565696e6720746869732c20636f6e67726174732e2e2e0a0a7e5361746f736869", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000091_7cd58fd6aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

