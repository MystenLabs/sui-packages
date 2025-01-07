module 0xfccbd12d2383a80e0d3b237a3ef09d16c85e84efa2c739f78234da726b03f8f5::homomo {
    struct HOMOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMOMO>(arg0, 6, b"HOMOMO", b"HOMOMOMO", b"HOMMOMO SIIIIM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/96633009_d1818000_1318_11eb_9f1d_7f914f4ccb16_3920816768.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOMOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

