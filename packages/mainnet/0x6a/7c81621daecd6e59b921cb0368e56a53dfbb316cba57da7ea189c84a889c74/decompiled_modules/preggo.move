module 0x6a7c81621daecd6e59b921cb0368e56a53dfbb316cba57da7ea189c84a889c74::preggo {
    struct PREGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PREGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PREGGO>(arg0, 6, b"PREGGO", b"Pregnant Seahorse", b"He's* pregnant", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/seahorse_63009a50f4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PREGGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PREGGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

