module 0xa06e726e066bda005f8af84e23cc17a2ea4f4cfd945c6254e02b28476ffd7b15::db {
    struct DB has drop {
        dummy_field: bool,
    }

    fun init(arg0: DB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DB>(arg0, 9, b"DB", b"Don't Buy", b"If you buy this, i Will donate to other", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6c2381c3-ddb6-4bb1-97d4-92212dc1ff5d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DB>>(v1);
    }

    // decompiled from Move bytecode v6
}

