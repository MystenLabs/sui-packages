module 0xd599414279fbd9934daa184dc476e130b91ad2139d0bdc1ffb03abe27f0c3c28::haaail {
    struct HAAAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAAAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAAAIL>(arg0, 6, b"Haaail", b"AAADolf CAT", b"Supporting the SUI Blockchain wif low GAS fee's", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cats_that_look_like_hitler_feat_1_620x350_06bedacccd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAAAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAAAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

