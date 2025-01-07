module 0x3b3e5e87c84caeab0cf0317703ccb6d0f1df7753cb6cbba36a17788122b94aab::lizsui {
    struct LIZSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIZSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIZSUI>(arg0, 6, b"Lizsui", b"Sui Lizzy", b"Lizzy on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gfbfgbf_a22b65df5c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIZSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIZSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

