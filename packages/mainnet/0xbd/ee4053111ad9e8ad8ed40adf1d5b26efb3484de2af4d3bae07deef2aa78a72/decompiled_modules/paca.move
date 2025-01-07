module 0xbdee4053111ad9e8ad8ed40adf1d5b26efb3484de2af4d3bae07deef2aa78a72::paca {
    struct PACA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PACA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PACA>(arg0, 6, b"PACA", b"SkiAlpaca", b"The alpaca goes on snow adventures!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_28_16_17_14_A_humorous_illustration_of_an_alpaca_skiing_down_a_snowy_slope_The_alpaca_should_have_a_joyful_expression_wearing_ski_goggles_and_moving_energetical_8a6446b8eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PACA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PACA>>(v1);
    }

    // decompiled from Move bytecode v6
}

