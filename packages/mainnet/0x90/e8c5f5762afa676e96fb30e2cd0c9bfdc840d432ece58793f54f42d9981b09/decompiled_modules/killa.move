module 0x90e8c5f5762afa676e96fb30e2cd0c9bfdc840d432ece58793f54f42d9981b09::killa {
    struct KILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KILLA>(arg0, 6, b"KILLA", b"killa", b"Out from the depths, I emerge. Stealth launch.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/profile_c3d786692e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

