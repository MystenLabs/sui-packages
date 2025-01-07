module 0x67b84c530a239e21620e5fff0d1941a144152d5a67b4b3092452ab4bf349c527::dogemas {
    struct DOGEMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEMAS>(arg0, 6, b"DOGEMAS", b"Sui Dogemas", b"Merry Dogemas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051990_54996535b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGEMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

