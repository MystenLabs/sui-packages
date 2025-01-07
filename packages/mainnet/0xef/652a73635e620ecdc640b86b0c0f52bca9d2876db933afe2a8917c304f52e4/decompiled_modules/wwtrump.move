module 0xef652a73635e620ecdc640b86b0c0f52bca9d2876db933afe2a8917c304f52e4::wwtrump {
    struct WWTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWTRUMP>(arg0, 6, b"WWTRUMP", b"WE WANT TRUMP", b"We need him, don't want her. Show your love to Trump ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmdq_K2_CGTBAXE_5_RHD_Ji_Du_F_Zf_FYCR_Hy4_HG_Zh_Qnihodvqam9_41016200f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WWTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

