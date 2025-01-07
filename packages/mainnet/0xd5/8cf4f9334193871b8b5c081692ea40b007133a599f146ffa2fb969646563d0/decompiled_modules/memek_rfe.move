module 0xd58cf4f9334193871b8b5c081692ea40b007133a599f146ffa2fb969646563d0::memek_rfe {
    struct MEMEK_RFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_RFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_RFE>(arg0, 6, b"MEMEKRFE", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_RFE>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_RFE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_RFE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

