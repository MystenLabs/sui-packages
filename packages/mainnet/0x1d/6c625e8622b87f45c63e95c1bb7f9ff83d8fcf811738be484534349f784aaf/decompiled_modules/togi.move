module 0x1d6c625e8622b87f45c63e95c1bb7f9ff83d8fcf811738be484534349f784aaf::togi {
    struct TOGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOGI>(arg0, 6, b"TOGI", b"Togi", b"Togi the jungle catto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241005_085418_30c408805d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

