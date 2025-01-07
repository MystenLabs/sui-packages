module 0x312203abeb2edc0ffcc9a04e6ac66ee872384b25031d41b1c67ef4073bcab81d::mugu {
    struct MUGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUGU>(arg0, 9, b"MUGU", b"Sui Mugu", b"Mugu legend of ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FKarya_Seni_Tanpa_Judul_36_cac61d364b.png&w=640&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MUGU>(&mut v2, 5500000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUGU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

