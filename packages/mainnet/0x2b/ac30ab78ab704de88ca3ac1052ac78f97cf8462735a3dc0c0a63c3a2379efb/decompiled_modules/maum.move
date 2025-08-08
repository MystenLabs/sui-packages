module 0x2bac30ab78ab704de88ca3ac1052ac78f97cf8462735a3dc0c0a63c3a2379efb::maum {
    struct MAUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAUM, arg1: &mut 0x2::tx_context::TxContext) {
        0x6b5611b90d9c8cfe87cabc75ee581bc199dd57849089d2be14bda2afc100885d::mtoken::create_coin<MAUM>(arg0, 9, b"MAUM", b"MAUM", b"MAUM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.matrixdock.com/images/xaum/xaum-64x64-icon.png")), true, 0, arg1);
    }

    // decompiled from Move bytecode v6
}

