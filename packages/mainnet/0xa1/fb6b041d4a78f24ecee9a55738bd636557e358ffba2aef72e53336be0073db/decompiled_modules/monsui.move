module 0xa1fb6b041d4a78f24ecee9a55738bd636557e358ffba2aef72e53336be0073db::monsui {
    struct MONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONSUI>(arg0, 6, b"MONSUI", b"Monsuikey", b"Monsuikey: The cheeky monkey on the Sui blockchain, bringing fun, memes, and a vibrant community. Hold $MONSUI and be part of the monkey madness.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_38_bba7444e38.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

