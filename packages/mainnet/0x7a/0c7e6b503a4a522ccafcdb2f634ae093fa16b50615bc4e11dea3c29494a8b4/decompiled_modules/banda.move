module 0x7a0c7e6b503a4a522ccafcdb2f634ae093fa16b50615bc4e11dea3c29494a8b4::banda {
    struct BANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANDA>(arg0, 6, b"BANDA", b"BANDA on SUI", x"4f6666696369616c20426561722050616e6461206f6e20535549210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x0_Ouor_Bd_400x400_73dc58b856.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

