module 0x44f82c44a223f76b397657ddcfe707623604889ba7de4e43d7791f439632dd72::hege {
    struct HEGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEGE>(arg0, 6, b"HEGE", b"Sui Hege", b"$hege in a nutshell...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hege_ef4ba877ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

