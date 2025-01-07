module 0x6cfb652b0e40dbec5ceaced1ffffb7ccfb3e8d59f86b9950e78252f15cd72b8e::poe {
    struct POE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POE>(arg0, 6, b"POE", b"Poe the Potato", b"Just a simple Poetato on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/poe_8b4fdb2ff9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POE>>(v1);
    }

    // decompiled from Move bytecode v6
}

