module 0x6997d3538f90b0ded8f2d490b09353308d0d075b687cf76ea729e7ffd77b0c2f::pogai {
    struct POGAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POGAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POGAI>(arg0, 6, b"POGAI", b"POGAIS", b"pogai pogai ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016538_9aa64e689d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POGAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POGAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

