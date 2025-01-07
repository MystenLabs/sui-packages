module 0x5591eabaf47cd7932c9949bcfb5bc352f28da8fd3758b41dbf4837dc46d06e40::sucks {
    struct SUCKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCKS>(arg0, 6, b"SUCKS", b"DuCk on Sui", b"The rich duck just arrive on Sui memeverse, Sucks is a rich duck on memecoin will giving you a wealth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2023_12_30_01_36_42_ASDASD_d2dfbe10ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUCKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

