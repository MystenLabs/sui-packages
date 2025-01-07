module 0x11fe0bcd6d481b7490464d13dd15f1db0b21d8cc17eab9ae712f99b0e6f334e8::pendb {
    struct PENDB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENDB>(arg0, 9, b"PENDB", b"jdndPWNS", b"ndnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/993db6eb-7e56-41cc-94c7-dba4aefb5a55.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENDB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PENDB>>(v1);
    }

    // decompiled from Move bytecode v6
}

