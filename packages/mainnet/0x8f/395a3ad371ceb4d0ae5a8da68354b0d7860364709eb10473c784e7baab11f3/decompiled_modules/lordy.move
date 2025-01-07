module 0x8f395a3ad371ceb4d0ae5a8da68354b0d7860364709eb10473c784e7baab11f3::lordy {
    struct LORDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LORDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LORDY>(arg0, 6, b"LORDY", b"Lordy", b"No other frog like Lordy. His quirky good looks and lordlike powers help him on his many based adventures.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LORDY_3c5f8258e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LORDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LORDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

