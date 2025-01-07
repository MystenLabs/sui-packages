module 0xafa9dd45322651c5244b525d5f948dd38e94338e0ebcb74017372d79f3e67d4e::tpump {
    struct TPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPUMP>(arg0, 6, b"Tpump", b"Trumpump", b"Trumpump is a meme coin inspired by humor and pop culture. We aim to create a fun and rewarding community for all token holders", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trumpump_e788d621b1.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

