module 0x5fb21a99a4dbd4812c2ef128b61e44671a0943708945b95a52c0135142247a48::poles {
    struct POLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLES>(arg0, 6, b"POLES", b"POLES SUI", b"Building the worlds of Ooga Republic and the Sidechick Society on #SUI, one pixel at a time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gt_HNI_xx_400x400_e45afdca6d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

