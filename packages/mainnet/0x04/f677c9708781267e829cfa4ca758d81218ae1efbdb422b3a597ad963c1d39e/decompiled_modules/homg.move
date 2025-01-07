module 0x4f677c9708781267e829cfa4ca758d81218ae1efbdb422b3a597ad963c1d39e::homg {
    struct HOMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMG>(arg0, 6, b"HOMG", b"Hands off my gains", b"The protector of gains is here. Sniper bot is coming soon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5718_8c02090550.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOMG>>(v1);
    }

    // decompiled from Move bytecode v6
}

