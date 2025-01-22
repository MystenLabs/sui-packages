module 0x31ceedcba8ce4fb86f0deb9ffbd487b957187b8f3dfd3a004a3be9550cfe1545::trumpdoge {
    struct TRUMPDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TRUMPDOGE>(arg0, 6, b"TRUMPDOGE", b"TRUMPDOGE by SuiAI", b"The two greatest memes in history unite to create the ultimate meme of all time: TrumpDoge on the Sui Chain!..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/0a053ad8_798a_4cc7_adf1_95becbb72123_1_1_1_1a4f471bd2_880b984796.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRUMPDOGE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPDOGE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

