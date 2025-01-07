module 0x5592617723bfc0abcf3aeee39aed601de36c81138dd99196ca5e6e1d8d462c0d::sato {
    struct SATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATO>(arg0, 6, b"SATO", b"Satoshui", b"Satoshui enter Sui world today.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sans_titre_13_6a99bdfd11.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

