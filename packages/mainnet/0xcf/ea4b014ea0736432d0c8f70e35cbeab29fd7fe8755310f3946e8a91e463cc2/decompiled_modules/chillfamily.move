module 0xcfea4b014ea0736432d0c8f70e35cbeab29fd7fe8755310f3946e8a91e463cc2::chillfamily {
    struct CHILLFAMILY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLFAMILY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLFAMILY>(arg0, 6, b"CHILLFAMILY", b"just a chillfamily", b"Just a CHILLFAMILY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chill_family_a0eccb98be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLFAMILY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLFAMILY>>(v1);
    }

    // decompiled from Move bytecode v6
}

