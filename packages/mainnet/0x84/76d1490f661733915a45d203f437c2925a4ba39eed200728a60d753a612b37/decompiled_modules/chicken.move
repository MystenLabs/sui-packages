module 0x8476d1490f661733915a45d203f437c2925a4ba39eed200728a60d753a612b37::chicken {
    struct CHICKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICKEN>(arg0, 6, b"CHICKEN", b"Chicken Trump", b"I don't want to debate the smart lady anymore ... ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SITE_f317ff41d0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHICKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

