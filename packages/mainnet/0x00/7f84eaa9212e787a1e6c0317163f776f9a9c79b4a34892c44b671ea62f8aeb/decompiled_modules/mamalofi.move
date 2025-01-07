module 0x7f84eaa9212e787a1e6c0317163f776f9a9c79b4a34892c44b671ea62f8aeb::mamalofi {
    struct MAMALOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMALOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMALOFI>(arg0, 6, b"MamaLofi", b"WifeofLofi", x"4920646f6ee2809974206b6e6f772077686574686572206f72206e6f7420492062656c6965766520696e20756e636f6e646974696f6e616c206c6f76652e20497420697320736f6d657468696e6720492068617665206265656e207468696e6b696e672061626f75742061206c6f74206c6174656c792061732049206e617669676174652072656c6174696f6e73686970732077697468207468652066616d696c7920492077617320626f726e20696e746f20616e6420617320492068617665206265636f6d652061206d6f746865722067726f77696e67206d79206f776e2063686f73656e2066616d696c792e202049206c6f7665206c6f666920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735970709906.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAMALOFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMALOFI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

