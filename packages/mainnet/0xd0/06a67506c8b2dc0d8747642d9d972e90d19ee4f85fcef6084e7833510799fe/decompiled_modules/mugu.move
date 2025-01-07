module 0xd006a67506c8b2dc0d8747642d9d972e90d19ee4f85fcef6084e7833510799fe::mugu {
    struct MUGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUGU>(arg0, 6, b"MUGU", b"Sui Mugu", b"Mugu legend of ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_36_cac61d364b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

