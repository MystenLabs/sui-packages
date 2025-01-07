module 0x1c574603ac054c78d793cc4d145fb5deddbb0a572107b859cf755060a14c8a10::jumpcat {
    struct JUMPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUMPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUMPCAT>(arg0, 6, b"JUMPCAT", b"Jump Cat", x"6a756d70696e6720696e746f2073756920287468696e6b696e672061626f757420537569290a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Japanese_Bobtail_white_6516c3801d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUMPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUMPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

