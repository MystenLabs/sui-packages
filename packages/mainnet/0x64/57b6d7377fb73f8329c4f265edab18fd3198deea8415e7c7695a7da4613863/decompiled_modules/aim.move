module 0x6457b6d7377fb73f8329c4f265edab18fd3198deea8415e7c7695a7da4613863::aim {
    struct AIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIM>(arg0, 6, b"Aim", b"Mickey Ai", b"Mickey Ai on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ekran_g_A_r_A_nt_A_s_A_2024_10_17_015152_a43258ee93.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

