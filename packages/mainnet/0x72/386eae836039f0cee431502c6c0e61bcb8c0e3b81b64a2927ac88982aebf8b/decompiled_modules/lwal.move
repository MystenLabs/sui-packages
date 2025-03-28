module 0x72386eae836039f0cee431502c6c0e61bcb8c0e3b81b64a2927ac88982aebf8b::lwal {
    struct LWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: LWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LWAL>(arg0, 6, b"LWAL", b"Little Walrus", b"Little Walrus Relaunch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9115_5aa44ba165.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LWAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LWAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

