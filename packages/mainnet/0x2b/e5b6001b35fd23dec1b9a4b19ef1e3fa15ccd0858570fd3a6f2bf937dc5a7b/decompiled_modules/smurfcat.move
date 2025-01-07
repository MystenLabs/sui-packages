module 0x2be5b6001b35fd23dec1b9a4b19ef1e3fa15ccd0858570fd3a6f2bf937dc5a7b::smurfcat {
    struct SMURFCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMURFCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMURFCAT>(arg0, 6, b"Smurfcat", b"Smurf cat on  sui", b"Smurf cat on  sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_09_15_42_23_75b5e81de3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMURFCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMURFCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

