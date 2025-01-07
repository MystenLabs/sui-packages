module 0x215e7714fb3e52e80ce947dd5dc8b7365f9d36ce9977b9f367448318a801d2f4::pigu {
    struct PIGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGU>(arg0, 6, b"PIGU", b"SUI PIGU", b"Navigating PIGU's world on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pigu_f75cbe5f9c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

