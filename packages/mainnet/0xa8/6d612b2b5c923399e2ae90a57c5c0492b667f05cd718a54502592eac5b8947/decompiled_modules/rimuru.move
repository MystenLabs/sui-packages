module 0xa86d612b2b5c923399e2ae90a57c5c0492b667f05cd718a54502592eac5b8947::rimuru {
    struct RIMURU has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIMURU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIMURU>(arg0, 6, b"RIMURU", b"RIMURU Tempest", b"meme anime on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001449_e608cf7563.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIMURU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIMURU>>(v1);
    }

    // decompiled from Move bytecode v6
}

