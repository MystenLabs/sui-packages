module 0xbdefb2f154a0f12c1dbdd332a40b1972853a81b8941b877b96e75f1ef34ad687::gran {
    struct GRAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRAN>(arg0, 6, b"Gran", b"granny", b"grandmother", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_27_11_19_47_343_com_zhiliaoapp_musically_edit_264b3c2e41.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

