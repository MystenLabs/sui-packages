module 0x3fee3b34a7a2a19393d8ac6045fa177a6b5af4d9b5ac279f52360fd7dacedfa0::bluey {
    struct BLUEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEY>(arg0, 6, b"Bluey", b"bluey", b"Meet SUI's new favourite doggo!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Z_Dsc9om6_400x400_14dabb8da6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

