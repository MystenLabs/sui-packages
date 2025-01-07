module 0x30b39829d644b173ca52297812062af432c968e36889987817a538feabc14832::pdeng {
    struct PDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDENG>(arg0, 6, b"PDENG", b"POPDENG", b"Bringing in the combination of two solana narrative of $POPCAT and $MOODENG into #SUI ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_23_59_31_f3a5a04d6b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

