module 0xc700d609e940dafa58877b18892ba06ad2c4429a4aee31d322ee0d46a669f5e5::testt {
    struct TESTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTT>(arg0, 6, b"TESTT", b"TEST", b"TTRREED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_04_18_40_50_A_bold_and_compact_futuristic_coin_logo_for_the_Swarm_token_designed_to_stand_out_even_at_smaller_sizes_Photoroom_797c4dfeb5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

