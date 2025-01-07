module 0x5b47f9bf012b14048aadf671ff4ed90de2b65d0f41ae120d42885e1ec0569fc1::pdeng {
    struct PDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDENG>(arg0, 6, b"Pdeng", b"Popdeng", b"LFG $POPDENG X1000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7fq_I_Ugz_A_400x400_c23763e0db.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

