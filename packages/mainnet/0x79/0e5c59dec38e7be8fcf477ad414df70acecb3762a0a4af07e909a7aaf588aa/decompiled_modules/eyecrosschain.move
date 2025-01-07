module 0x790e5c59dec38e7be8fcf477ad414df70acecb3762a0a4af07e909a7aaf588aa::eyecrosschain {
    struct EYECROSSCHAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: EYECROSSCHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYECROSSCHAIN>(arg0, 6, b"t.me/eyecrosschain", b"t.me/eyecrosschain", b"telegram: eyecrosschain and elcartelounge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/6bBDblX.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EYECROSSCHAIN>>(v1);
        0x2::coin::mint_and_transfer<EYECROSSCHAIN>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<EYECROSSCHAIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

