module 0xd309d12c4f621f1084c3aedfe661ac026ce8ced3644a3c183d15457fa87f6126::babywlfi {
    struct BABYWLFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYWLFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYWLFI>(arg0, 6, b"BABYWLFI", b"BABY WLFI", b"We are first BABY WLFI on Sui , let's make a history here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3609_fa52f91a2e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYWLFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYWLFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

