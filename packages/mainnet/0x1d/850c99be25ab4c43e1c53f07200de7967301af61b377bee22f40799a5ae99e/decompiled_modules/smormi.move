module 0x1d850c99be25ab4c43e1c53f07200de7967301af61b377bee22f40799a5ae99e::smormi {
    struct SMORMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMORMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMORMI>(arg0, 6, b"SMORMI", b"SMORMU", b"Who hasn't met $SMORMU yet, it's time to get acquainted. It's a legendary shrimp that has gained popularity on Twitter, YouTube, and Reddit. It's time to pay homage to this meme. Meet SMORMU on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036875_ddf744e3cd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMORMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMORMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

