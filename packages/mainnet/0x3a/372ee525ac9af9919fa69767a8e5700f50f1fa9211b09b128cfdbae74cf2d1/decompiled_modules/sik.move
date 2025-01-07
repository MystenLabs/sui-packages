module 0x3a372ee525ac9af9919fa69767a8e5700f50f1fa9211b09b128cfdbae74cf2d1::sik {
    struct SIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIK>(arg0, 6, b"SIK", b"SUITALIK", b"Vitalik is discovering SUI ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/555_1ba501af75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

