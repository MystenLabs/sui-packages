module 0x608c7cc782dd81db5cc21dc5e933ef196df3d6ead674aee748891b1708b2a563::suidness {
    struct SUIDNESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDNESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDNESS>(arg0, 6, b"SUIDNESS", b"Inside Sui", b"What's inside?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_211159_d082645961.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDNESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDNESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

