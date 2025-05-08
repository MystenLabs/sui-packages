module 0x50746813d5f749763fba720da82f5ba15f101dd2e1e26f5f3a26706f996616c0::hasuibi {
    struct HASUIBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASUIBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASUIBI>(arg0, 6, b"HASUIBI", b"Hasuibi", x"59616c6c616820686162696269206869706f206f662073756920697320746865207265616c20686175736962690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_HXAWPO_4_400x400_66d038b947.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASUIBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HASUIBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

