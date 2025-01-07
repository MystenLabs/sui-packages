module 0x8d1433b833b3c5cc99a086ce39dddda00a760b3d4921229e6944b749e25fce8a::bogyy {
    struct BOGYY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOGYY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOGYY>(arg0, 6, b"BOGYY", b"BOGYYSUI", b"BOGYY ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bynznk2d_400x400_2df50fd03c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOGYY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOGYY>>(v1);
    }

    // decompiled from Move bytecode v6
}

