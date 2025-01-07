module 0x2cf264299e4f155d34660fd7ba14352d57260347af91c279c1898a8e75464c2a::srug {
    struct SRUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRUG>(arg0, 6, b"SRUG", b"SPLO RUG", b"FCK SPLO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SPLO_9fe99b0b46.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

