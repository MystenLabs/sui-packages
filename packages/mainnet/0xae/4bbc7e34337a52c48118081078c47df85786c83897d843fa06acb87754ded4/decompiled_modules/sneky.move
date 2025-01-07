module 0xae4bbc7e34337a52c48118081078c47df85786c83897d843fa06acb87754ded4::sneky {
    struct SNEKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNEKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNEKY>(arg0, 6, b"SNEKY", b"Snekky SUI", b"Meet Snekky, the vibrant and adventurous snake from Matt Furies Night Riders. Debuting in this iconic book, Snekky embodies the whimsical and surreal style that degens adore.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/snaky_and_friend3_bf98a672da.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNEKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNEKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

