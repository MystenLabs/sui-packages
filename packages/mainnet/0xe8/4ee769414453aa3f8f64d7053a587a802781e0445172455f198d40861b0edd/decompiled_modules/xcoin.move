module 0xe84ee769414453aa3f8f64d7053a587a802781e0445172455f198d40861b0edd::xcoin {
    struct XCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: XCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XCOIN>(arg0, 6, b"XCoin", b"XCoin ", b"X Coin is a New Bitcoin Alternative Built on SUI - For the People - By the People. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735542511952.27")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

