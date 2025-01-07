module 0xfb089456df96f13837409a6a640b5de46ab51ea03f98f61ebe69b1585e52b542::spoony {
    struct SPOONY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOONY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOONY>(arg0, 6, b"SPOONY", b"SPOONY the autistic fish", b"wElcOmE tO My gLAsS tANk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9181_346cd0efab.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOONY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOONY>>(v1);
    }

    // decompiled from Move bytecode v6
}

