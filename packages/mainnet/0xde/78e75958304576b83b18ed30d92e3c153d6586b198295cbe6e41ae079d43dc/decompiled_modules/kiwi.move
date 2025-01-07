module 0xde78e75958304576b83b18ed30d92e3c153d6586b198295cbe6e41ae079d43dc::kiwi {
    struct KIWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIWI>(arg0, 6, b"KIWI", b"Kiwi on Sui", b"These kiwi birds are literally just walking kiwi fruit, it's kinda wild!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kiki_641cfbd2d7.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

