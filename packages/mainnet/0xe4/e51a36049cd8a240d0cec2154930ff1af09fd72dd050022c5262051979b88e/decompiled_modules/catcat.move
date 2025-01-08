module 0xe4e51a36049cd8a240d0cec2154930ff1af09fd72dd050022c5262051979b88e::catcat {
    struct CATCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATCAT>(arg0, 9, b"CATCAT", b"Tokcat", b"Wave is best project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3090e2ff-7cef-42f8-b177-f67cbe2d7167.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

