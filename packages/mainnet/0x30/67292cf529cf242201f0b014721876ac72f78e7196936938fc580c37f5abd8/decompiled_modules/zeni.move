module 0x3067292cf529cf242201f0b014721876ac72f78e7196936938fc580c37f5abd8::zeni {
    struct ZENI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZENI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZENI>(arg0, 6, b"ZENI", b"ZENI SUI", b"Goo goo, gaa gaa! The little zeni is ready to make his father proud! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2023_12_24_16_47_05_a96c957710.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZENI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZENI>>(v1);
    }

    // decompiled from Move bytecode v6
}

