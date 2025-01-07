module 0x73ee324913c439163430f927dfd082cc48dd3c2d46bc28be8b91eaf4ec5cfbeb::aastonks {
    struct AASTONKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AASTONKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AASTONKS>(arg0, 6, b"aaSTONKS", b"aaaaaaaaaaaaaaSTONKS", b"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaSTONKS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/siiiga_742f4abf90.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AASTONKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AASTONKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

