module 0xf50a3c78527000a75ec4461965c03d25f25a188f6e24a36aea6f2484b23236db::dory {
    struct DORY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORY>(arg0, 6, b"DORY", b"Dory The Fish", b"Dory is a blue tang fish from Pixar's \"Finding Nemo\" and \"Finding Dory.\"She is friendly but has short-term memory loss, leading her on adventures to find her family.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_12_23_34_11_e470c0f7a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORY>>(v1);
    }

    // decompiled from Move bytecode v6
}

