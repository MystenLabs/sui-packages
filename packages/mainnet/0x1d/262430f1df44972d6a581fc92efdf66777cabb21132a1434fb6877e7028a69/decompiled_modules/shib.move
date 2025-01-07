module 0x1d262430f1df44972d6a581fc92efdf66777cabb21132a1434fb6877e7028a69::shib {
    struct SHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIB>(arg0, 6, b"SHIB", b"Reddit Black Shiba Inu", b" We introduce to you $r/shiba, the luxury $SHIB on Sui. Led by the community and inspired by the legacy. Join the community and become part of the next $SHIB of this cycle.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250103_155032_871_01d10ddc06.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

