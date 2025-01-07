module 0x52888ea0fe33b93eafded1c594a7538f0c20346454f5785598d008e23baa121c::pengucorn {
    struct PENGUCORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGUCORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGUCORN>(arg0, 6, b"PENGUCORN", b"Pengu unicorn", b"Penguin Unicorn is pure magic. $PENGUCORN is the legendary fusion of icy pengu vibes and wild unicorn hype. We are gliding straight to greatness!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054132_b1218c25a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGUCORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGUCORN>>(v1);
    }

    // decompiled from Move bytecode v6
}

