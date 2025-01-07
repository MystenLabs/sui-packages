module 0x6092f20fdbaee5b372c4ceacc7af3c3f5601bd2457d97ae99d93f73829a4e96f::phil {
    struct PHIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHIL>(arg0, 6, b"PHIL", b"SUI PHIL", b"First there was Phil! Only to be awoken when needed the most.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yr0k_M_Urz_400x400_cfbe6d7108.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

