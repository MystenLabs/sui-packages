module 0x843b6ff8db3e971208923720671ff52eafb56deb026afbc2a2a1abd1956597e7::michi {
    struct MICHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MICHI>(arg0, 6, b"MICHI", b"Michi on SUI", b"The Infinity meme cat is already on SUI. Get ready to fill up your bags.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/michi_a04407ccf9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MICHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

