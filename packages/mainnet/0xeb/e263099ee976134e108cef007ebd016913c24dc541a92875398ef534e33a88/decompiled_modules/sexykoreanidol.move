module 0xebe263099ee976134e108cef007ebd016913c24dc541a92875398ef534e33a88::sexykoreanidol {
    struct SEXYKOREANIDOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEXYKOREANIDOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEXYKOREANIDOL>(arg0, 6, b"SexyKoreanidol", b"Sexy Korean idol", b"Sexy Korean idol will list exchange! My whale friend coming! BUY!BUY!BUY!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_26_22_38_17_A_stylish_and_glamorous_depiction_of_a_sexy_Korean_female_idol_in_a_chic_outfit_She_has_a_confident_and_fierce_expression_wearing_a_sleek_black_leat_3fb8e2618b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEXYKOREANIDOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEXYKOREANIDOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

