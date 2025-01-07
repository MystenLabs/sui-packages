module 0x8be9dc9467578421aab79550eda159e58a6c3e877909dc563d55245bb6bb3e20::funru {
    struct FUNRU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUNRU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUNRU>(arg0, 6, b"FUNRU", b"FUNRU SUI", b"FUNRU ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/afbf12b365d3907035a2d7b93349dc20_removebg_preview_7fc27a1938.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUNRU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUNRU>>(v1);
    }

    // decompiled from Move bytecode v6
}

