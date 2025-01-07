module 0x54c603288a940e9183084648437af96d0a8c221c877476db5bf94dab43e3c276::repucat {
    struct REPUCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: REPUCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REPUCAT>(arg0, 6, b"REPUCAT", b"Cat of Republic", b"American Republic with the Victorious Cat symbol. !!!VICTORY IS IN SIGHT!!! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1002808067_ee87495eab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REPUCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REPUCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

