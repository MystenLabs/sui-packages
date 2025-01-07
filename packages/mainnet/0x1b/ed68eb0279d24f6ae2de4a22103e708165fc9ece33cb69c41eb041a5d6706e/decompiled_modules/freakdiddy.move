module 0x1bed68eb0279d24f6ae2de4a22103e708165fc9ece33cb69c41eb041a5d6706e::freakdiddy {
    struct FREAKDIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREAKDIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREAKDIDDY>(arg0, 6, b"FREAKDIDDY", b"Freak Diddy", b"Step into the chaos. Join the FREAKDIDDY revolution, where finance meets controversy and partying never stops.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sean_combs_throwing_money_puff_daddy_p_diddy_1d6d7d46d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREAKDIDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FREAKDIDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

