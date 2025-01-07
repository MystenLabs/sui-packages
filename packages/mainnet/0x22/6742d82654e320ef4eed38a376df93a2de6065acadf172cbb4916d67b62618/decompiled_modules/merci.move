module 0x226742d82654e320ef4eed38a376df93a2de6065acadf172cbb4916d67b62618::merci {
    struct MERCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MERCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERCI>(arg0, 6, b"MERCI", b"DONNE", b"DADA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/spy_55822de978.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERCI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MERCI>>(v1);
    }

    // decompiled from Move bytecode v6
}

