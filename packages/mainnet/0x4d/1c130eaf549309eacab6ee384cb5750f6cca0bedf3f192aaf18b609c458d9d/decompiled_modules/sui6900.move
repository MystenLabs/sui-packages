module 0x4d1c130eaf549309eacab6ee384cb5750f6cca0bedf3f192aaf18b609c458d9d::sui6900 {
    struct SUI6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI6900>(arg0, 6, b"SUI6900", b"Sui6900", b"OFFICIAL $SUI6900 COMING TO SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_koin_fa2d165916.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

