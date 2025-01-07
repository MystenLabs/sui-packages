module 0x65780c01c56035843e1f04641a9a77662aa8d9bbf9e238e7236776eeddb2c948::longday {
    struct LONGDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LONGDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LONGDAY>(arg0, 9, b"LONGDAY", b"Long day", b"a long day", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d337e2df-4814-4f78-9f5f-9c0769fdccb7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LONGDAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LONGDAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

