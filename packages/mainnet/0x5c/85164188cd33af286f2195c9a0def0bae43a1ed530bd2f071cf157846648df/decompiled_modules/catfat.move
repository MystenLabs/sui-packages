module 0x5c85164188cd33af286f2195c9a0def0bae43a1ed530bd2f071cf157846648df::catfat {
    struct CATFAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATFAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATFAT>(arg0, 6, b"CATFAT", b"FATCAT", b"believed to bring good luck to the owner", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_coin1_a75ec08066.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATFAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATFAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

