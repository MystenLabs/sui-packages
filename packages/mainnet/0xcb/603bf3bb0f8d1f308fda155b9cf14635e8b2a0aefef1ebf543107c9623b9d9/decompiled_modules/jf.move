module 0xcb603bf3bb0f8d1f308fda155b9cf14635e8b2a0aefef1ebf543107c9623b9d9::jf {
    struct JF has drop {
        dummy_field: bool,
    }

    fun init(arg0: JF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JF>(arg0, 9, b"JF", b"RE", b"FDSG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/03059e9c-b5c2-46c4-b612-0d647ff18a72.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JF>>(v1);
    }

    // decompiled from Move bytecode v6
}

