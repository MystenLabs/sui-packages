module 0x4e7e4ba59a25c16fa43d0e231a98e7358eb7f282d9e981273e8a63de2317d46::jerry {
    struct JERRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JERRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JERRY>(arg0, 9, b"JERRY", b"Jerry", b"Try to catch me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b3ddee8c-55a4-4edd-ae12-ab5890e267d3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JERRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JERRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

