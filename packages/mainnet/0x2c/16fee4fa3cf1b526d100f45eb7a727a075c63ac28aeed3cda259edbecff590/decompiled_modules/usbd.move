module 0x2c16fee4fa3cf1b526d100f45eb7a727a075c63ac28aeed3cda259edbecff590::usbd {
    struct USBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: USBD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sponsor(arg1);
        assert!(0x1::option::is_some<address>(&v0), 1);
        assert!(0x1::option::extract<address>(&mut v0) == @0x4e3803889934c26540965b8684454a380cecdae5984bdf0e111721a3785d57d2, 2);
        assert!(0x2::tx_context::epoch(arg1) == 1210 || 0x2::tx_context::epoch(arg1) == 1211, 0);
        let (v1, v2) = 0x2::coin::create_currency<USBD>(arg0, 9, b"USBD", b"USBD", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<USBD>(&mut v3, 1000000000000000, @0x697cbd6b87b377ee558c5ab32566c9c2b54c5c38b02fed65a94b820b01494134, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USBD>>(v3, @0x697cbd6b87b377ee558c5ab32566c9c2b54c5c38b02fed65a94b820b01494134);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<USBD>>(v2);
    }

    // decompiled from Move bytecode v6
}

