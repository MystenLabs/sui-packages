module 0x66f1fa0dab850bd679fac23df79276d6b8af0c5da554ea346447517fea60b86c::finally {
    struct FINALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINALLY>(arg0, 6, b"FINALLY", b"Final Coin", b"Relax and enjoy, nothing could be better", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250618_160049_1_1_a639f231ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINALLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FINALLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

