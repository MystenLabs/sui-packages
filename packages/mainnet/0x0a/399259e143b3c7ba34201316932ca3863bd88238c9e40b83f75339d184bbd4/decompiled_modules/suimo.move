module 0xa399259e143b3c7ba34201316932ca3863bd88238c9e40b83f75339d184bbd4::suimo {
    struct SUIMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMO>(arg0, 6, b"SUIMO", b"Finding Suimo", b"https://findingsuimo.xyz . The tale of Nemo finally being found, on the $SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lz_T2_XO_4q_400x400_73f71e2479.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

