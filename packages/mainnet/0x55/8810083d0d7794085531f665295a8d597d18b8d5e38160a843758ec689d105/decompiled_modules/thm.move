module 0x558810083d0d7794085531f665295a8d597d18b8d5e38160a843758ec689d105::thm {
    struct THM has drop {
        dummy_field: bool,
    }

    fun init(arg0: THM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THM>(arg0, 6, b"THM", b"Trump Heman", b"Welcome to Castle Grayskull... the TRUMP HE-MAN TOKEN house... the more tokens you have... the more power of Grayskull you will have!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trumpo_logo_2_3c8e800cb3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THM>>(v1);
    }

    // decompiled from Move bytecode v6
}

