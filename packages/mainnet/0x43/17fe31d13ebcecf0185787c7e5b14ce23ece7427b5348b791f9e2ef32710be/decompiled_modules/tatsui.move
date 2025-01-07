module 0x4317fe31d13ebcecf0185787c7e5b14ce23ece7427b5348b791f9e2ef32710be::tatsui {
    struct TATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TATSUI>(arg0, 6, b"TATSUI", b"Tatsuigiri", b"Tatsuigiri is fighting his way to become the official SUI mascot! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/base_882c9a4023.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

