module 0xefa3eefdc8518c9a2025ad6cbd049ae247eefc2e743f2ec578c809a5dcb05672::dgtu {
    struct DGTU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGTU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGTU>(arg0, 6, b"DGTU", b"Dog Tongue", x"444f4720544f4e475545206973206e6f206f7264696e61727920646f67206375746520627574207374726f6e6720696e74656c6c6967656e7420616e640a70657273697374656e742c20686520726f616d7320746865207661737420706c61696e732077697468206e6f626c6520676f616c730a0a6361726566756c6c79206e617669676174696e67206368616c6c656e67657320616e6420616c77617973206c6f6f6b696e6720666f72206f70706f7274756e697469657320746f20696d70726f76652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibja4oguuugvqojiza3exj7lruj5nec5cdtc2ugbmzxwkvl5frvtu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGTU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DGTU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

