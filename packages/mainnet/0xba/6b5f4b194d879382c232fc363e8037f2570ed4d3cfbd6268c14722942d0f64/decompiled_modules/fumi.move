module 0xba6b5f4b194d879382c232fc363e8037f2570ed4d3cfbd6268c14722942d0f64::fumi {
    struct FUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUMI>(arg0, 6, b"FUMI", b"FUMIKO The Working Cat", b"She works hard so her human can nap harder.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6179_59a5186db9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

