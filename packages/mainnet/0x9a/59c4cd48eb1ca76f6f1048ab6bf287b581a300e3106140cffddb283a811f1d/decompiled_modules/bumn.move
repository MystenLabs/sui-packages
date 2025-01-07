module 0x9a59c4cd48eb1ca76f6f1048ab6bf287b581a300e3106140cffddb283a811f1d::bumn {
    struct BUMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUMN>(arg0, 9, b"BUMN", b"BUMooN", b"BUMooN is a Eco-Living Token that aims to be dividend tools between its green project closed-loop revenue and user.  Currently there are 4 BUMooN green projects including profitable work and pure charity. Revenue generated within profitable projects category will be repurchased as the profitable projects underlying assets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bscscan.com/token/images/bumoon_32.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUMN>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUMN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

