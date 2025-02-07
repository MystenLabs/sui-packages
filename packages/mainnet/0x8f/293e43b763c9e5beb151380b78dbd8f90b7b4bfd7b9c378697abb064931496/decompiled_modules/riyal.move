module 0x8f293e43b763c9e5beb151380b78dbd8f90b7b4bfd7b9c378697abb064931496::riyal {
    struct RIYAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIYAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIYAL>(arg0, 6, b"RIYAL", b"Riyal Suidi", b"Riyal Suidi, Major pair on Suidi Kingdom ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000051940_ef3b5927e9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIYAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIYAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

