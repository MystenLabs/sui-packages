module 0xa5f93cc7a731391dcaf0d03d3ab648164fa7927eaf7a9ffe8a47a14ec625f448::chappy {
    struct CHAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAPPY>(arg0, 6, b"Chappy", b"CHAPPY SUI AI", x"5472616465207769746820414920496e73696768747320210a4f757220616476616e63656420616c676f726974686d732070696e706f696e742062757920616e642073656c6c2074696d696e67732c20686967686c6967687420706f74656e7469616c207275672070756c6c732c20616e642070726f76696465206120736563757265207061746820746f206d656d65636f696e20737563636573732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul78_20250111024728_5ef6ca1818.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

