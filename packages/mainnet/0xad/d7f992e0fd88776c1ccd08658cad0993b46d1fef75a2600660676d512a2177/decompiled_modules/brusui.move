module 0xadd7f992e0fd88776c1ccd08658cad0993b46d1fef75a2600660676d512a2177::brusui {
    struct BRUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRUSUI>(arg0, 6, b"BRUSUI", b"BRUCE", b"Fish are friends, not food...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/22uh2k_cf754735ed.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRUSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

