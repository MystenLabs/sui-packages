module 0xd97960b125ead5ffb1999666f8617c18b09f2b8dc12af88654a15a73673f2ecf::jye {
    struct JYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JYE>(arg0, 9, b"JYE", b"KGE", b"But I don't ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c8ff9bd-1f54-4ccc-8f20-9fc971ae6044.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

