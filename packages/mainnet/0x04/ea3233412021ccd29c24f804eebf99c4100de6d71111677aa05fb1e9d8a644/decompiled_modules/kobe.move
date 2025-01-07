module 0x4ea3233412021ccd29c24f804eebf99c4100de6d71111677aa05fb1e9d8a644::kobe {
    struct KOBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOBE>(arg0, 6, b"Kobe", b"kobe inu", b"Shiba Inu's twin brother", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/a_ae_a_c_20240925050804_09e50e7a1a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

