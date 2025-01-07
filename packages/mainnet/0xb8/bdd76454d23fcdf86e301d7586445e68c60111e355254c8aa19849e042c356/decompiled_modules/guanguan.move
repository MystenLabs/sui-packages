module 0xb8bdd76454d23fcdf86e301d7586445e68c60111e355254c8aa19849e042c356::guanguan {
    struct GUANGUAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUANGUAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUANGUAN>(arg0, 6, b"Guanguan", b"GuanYin coin", b"To celebrate Guan Yin 1th Birth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1d9edc9d9ebfd7d8416441a6835280e_445d501445.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUANGUAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUANGUAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

