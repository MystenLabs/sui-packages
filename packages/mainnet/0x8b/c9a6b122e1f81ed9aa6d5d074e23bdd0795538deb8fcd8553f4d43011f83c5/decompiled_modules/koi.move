module 0x8bc9a6b122e1f81ed9aa6d5d074e23bdd0795538deb8fcd8553f4d43011f83c5::koi {
    struct KOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOI>(arg0, 6, b"KOI", b"SUIKOI", b"FCK SPLO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/koi_b3af03b499.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

