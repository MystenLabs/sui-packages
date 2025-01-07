module 0x4255a0f2ff302b83f71b53907cfc228e7240b56f1e81aa1caf7b44e2554a5e64::orc {
    struct ORC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORC>(arg0, 6, b"ORC", b"First Orc On Sui", b"First Orc On Sui: https://www.orcsui.pro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_16_86c10bbd90.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORC>>(v1);
    }

    // decompiled from Move bytecode v6
}

