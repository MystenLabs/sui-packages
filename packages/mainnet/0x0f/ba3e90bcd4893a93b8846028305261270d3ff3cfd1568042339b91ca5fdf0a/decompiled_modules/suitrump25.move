module 0xfba3e90bcd4893a93b8846028305261270d3ff3cfd1568042339b91ca5fdf0a::suitrump25 {
    struct SUITRUMP25 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITRUMP25, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITRUMP25>(arg0, 6, b"Suitrump25", b"SUITRUMP2025", b"SUITRUMP is a reminder of the importance of knowledge and political word power", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2532_abacbca74a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITRUMP25>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITRUMP25>>(v1);
    }

    // decompiled from Move bytecode v6
}

