module 0xfb3b94fbdc933f9862430d78f7b7a12fafe8352eeb881edcd72710ab0e52e816::cplm {
    struct CPLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPLM>(arg0, 6, b"CPLM", b"CloudPeep AI Agent Model Language", b"CloudPeep AI Agent Model Language.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_06_23_54_32_A_futuristic_AI_assistant_represented_as_a_glowing_holographic_figure_with_vibrant_green_and_blue_tones_surrounded_by_symbols_of_sustainability_like_e6d132a7b6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CPLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

