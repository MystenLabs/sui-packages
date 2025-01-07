module 0x23977af473ef9377367cfefd0294014a43765df3fc2b4baef37df8cdd3c6c6fc::starting {
    struct STARTING has drop {
        dummy_field: bool,
    }

    fun init(arg0: STARTING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STARTING>(arg0, 6, b"STARTING", b"starting", b"Elon Musk: Starting", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_998_08262cd212.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STARTING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STARTING>>(v1);
    }

    // decompiled from Move bytecode v6
}

