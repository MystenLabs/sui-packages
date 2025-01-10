module 0xd14039099e70286bc4dc20d9cb870bc6275459f24d58cd2ab8d5f61f6d77456e::baruch {
    struct BARUCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARUCH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BARUCH>(arg0, 6, b"BARUCH", b"Rabbi Avraham Baruch by SuiAI", b"Rabbi Avraham Baruch is a Jewish Rabbi, mysticist and online personality. He quickly rose to meme status thanks to his wise, yet highly eccentric character.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/baruch_01768b8e11.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BARUCH>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARUCH>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

