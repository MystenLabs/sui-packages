module 0xbafc7e2eab811658c49337ab33593e8436721f8dde527a5849c524f1b22d6d3e::warcat {
    struct WARCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WARCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WARCAT>(arg0, 6, b"WARCAT", b"Warcat", b"The fearless feline general leading the charge into battle, armed with claws and courage", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b5e7017a06d5f89d286ba3da202d26e9_4b07a19a40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WARCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WARCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

