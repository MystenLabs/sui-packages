module 0x7991666177ae6925f1ac173b97e7ce0884e921d10622df20f9abcec9495b6a95::tigo {
    struct TIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIGO>(arg0, 6, b"TIGO", b"TIGO on SUI", b"$TIGO the meme coin on network SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Aa_A5_Jn_NW_400x400_d158b194ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

