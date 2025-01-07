module 0x1a2a2aece44466939aaf671ec4b874035cfe6e9425a6d29e9d9b13b3b2025518::planksui {
    struct PLANKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLANKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLANKSUI>(arg0, 6, b"PLANKSUI", b"Planksui", b"Planksui, a tiny, but brave plankton on the Sui Network, let's pump!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/adadad_ed39ef0ff6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLANKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLANKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

