module 0x51040125c1b1bbda700f93444503d46d5ec50d4ca00fb9734cc72934d1835b2b::suicards {
    struct SUICARDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICARDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICARDS>(arg0, 6, b"SUICARDS", b"SUI CARDS", b"First meme card on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1233_80a40e782f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICARDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICARDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

