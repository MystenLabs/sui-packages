module 0xe94367587c35724080a6577123ec863192db12afc3ec9b9e2c07a04e2f5d5a28::drogan {
    struct DROGAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROGAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROGAN>(arg0, 6, b"DROGAN", b"Joe Drogan", b"Dragon Believer!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016755_7f5cd12f96.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROGAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROGAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

