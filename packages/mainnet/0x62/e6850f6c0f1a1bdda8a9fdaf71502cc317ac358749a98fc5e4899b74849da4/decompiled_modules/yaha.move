module 0x62e6850f6c0f1a1bdda8a9fdaf71502cc317ac358749a98fc5e4899b74849da4::yaha {
    struct YAHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAHA>(arg0, 6, b"YAHA", b"SUYAHA", b"YAHA Coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOLA_DEGEN_5b4fb860d4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAHA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YAHA>>(v1);
    }

    // decompiled from Move bytecode v6
}

