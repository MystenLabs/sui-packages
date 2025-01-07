module 0x2ebb4f152a57837ee1c3e60fe537d66ad384527a6c6075935129727fb77ea252::mctoken {
    struct MCTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCTOKEN>(arg0, 6, b"McToken", b"McDuckToken", b"The McDuck Token is a token created for meme lovers. The creator of the token, McT, has set himself an ambitious goal  to get fabulously rich and give all members of his community the opportunity to earn.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mc_Token_T_Db_W_Wa_hwq6_Rx_Cq3a_Tl_fd584bedb8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

