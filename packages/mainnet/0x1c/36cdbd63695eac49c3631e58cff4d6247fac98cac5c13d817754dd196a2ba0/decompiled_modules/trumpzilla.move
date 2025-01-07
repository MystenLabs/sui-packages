module 0x1c36cdbd63695eac49c3631e58cff4d6247fac98cac5c13d817754dd196a2ba0::trumpzilla {
    struct TRUMPZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPZILLA>(arg0, 6, b"Trumpzilla", b"Godzilla Trump", b"Godzilla Trump 100x", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tgrg_8c689cd05d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPZILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPZILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

