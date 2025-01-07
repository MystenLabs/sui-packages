module 0xa97edfb41c1ec8a32ada68d9c410522b7502aaa05e46525d9dda5a3d6fdb4836::winsa {
    struct WINSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINSA>(arg0, 9, b"WINSA", b"WINSA", b"WINSA", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WINSA>(&mut v2, 123456789000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINSA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

