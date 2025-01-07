module 0x19360ccde0e9f7d453fd9ce861266f3cb329b53bc7e3fe8792b7564b88c4b736::eater {
    struct EATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: EATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EATER>(arg0, 6, b"Eater", b"Sui eater", b"I'll take her soul you all Chad's and spit it out on Dex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012292_1005c94dda.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

