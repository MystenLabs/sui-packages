module 0x3317d368b41e067a89879174438a952c3b86e8249b517fb059657996debed692::wopy {
    struct WOPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOPY>(arg0, 6, b"WOPY", b"Sui Wopy", b"$WOPY the next mascot of SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_42_d6b40ac557.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

