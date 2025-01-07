module 0x431a78d14a152f06f9f67ba1d59f0fdfaf9299345c5d56b4b1b2a2dd05b5c6ff::steen {
    struct STEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEEN>(arg0, 6, b"STEEN", b"STEENSUI", x"537465656e2c20746865204d65616e2050696e6b204265616e0a466f6c6c6f772026206a6f696e20546f206765742074686520757064617465200a54656c656772616d203a2068747470733a2f2f742e6d652f737465656e5355490a58203a2068747470733a2f2f782e636f6d2f535445454e5355490a576562736974653a2068747470733a2f2f737465656e7375692e6d792e63616e76612e736974652f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241208_164859_164_05c040468b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

