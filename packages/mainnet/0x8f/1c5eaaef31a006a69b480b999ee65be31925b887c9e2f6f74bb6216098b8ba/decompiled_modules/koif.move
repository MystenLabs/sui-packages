module 0x8f1c5eaaef31a006a69b480b999ee65be31925b887c9e2f6f74bb6216098b8ba::koif {
    struct KOIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOIF>(arg0, 6, b"KOIF", b"FERIEU", b"MS PK JE IN PUTAIN KOIF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Chubz_212a244dc2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

