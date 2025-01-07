module 0xe2ffcc647ed5a56d734ba766a4e20a413d1effc9cda85dba611235fe7816ae47::ttai {
    struct TTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTAI>(arg0, 6, b"TTAI", b"TrashTalkerAI", b"TrashTalkerAI ($TTAI) is a groundbreaking cryptocurrency powered by an AI designed to insult, roast, and banter with people in the most entertaining way imaginable. TrashTalkerAI combines humor, technology, and AI world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735946720527.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TTAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

