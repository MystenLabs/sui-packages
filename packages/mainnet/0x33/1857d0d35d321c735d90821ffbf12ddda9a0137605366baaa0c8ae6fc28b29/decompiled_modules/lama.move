module 0x331857d0d35d321c735d90821ffbf12ddda9a0137605366baaa0c8ae6fc28b29::lama {
    struct LAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMA>(arg0, 6, b"LAMA", b"Lama On SUI", b"Don't get left behind on Sui Network. Here is your final Chance!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LAMA_fe713e2fe0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

