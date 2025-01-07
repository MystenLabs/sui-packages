module 0x3ebf891c4489c44486ed0e9c67505f043c450610b0a73af54f1aad25e9226f8b::kb {
    struct KB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KB>(arg0, 9, b"KB", b"Kantong", b"Kantong Bird is a mascot of YouTube channel \"Kantong Bijak\" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/58f78481-9290-4566-a0d2-53e0647dff2a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KB>>(v1);
    }

    // decompiled from Move bytecode v6
}

