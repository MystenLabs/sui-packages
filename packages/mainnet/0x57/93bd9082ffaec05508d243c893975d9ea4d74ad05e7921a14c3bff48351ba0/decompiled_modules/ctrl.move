module 0x5793bd9082ffaec05508d243c893975d9ea4d74ad05e7921a14c3bff48351ba0::ctrl {
    struct CTRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTRL>(arg0, 6, b"CTRL", b"Control Token", b"controltoken.net", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_800_I_Ws_400x400_77f25464e0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

