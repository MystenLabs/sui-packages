module 0xeb375b23b48501e36e9f0ba13e7ed907d16c9c1a7b7ed02c460a23f6f80fd6e::mymiken86 {
    struct MYMIKEN86 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYMIKEN86, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYMIKEN86>(arg0, 9, b"MYMIKEN86", b"Miriam", b"Good project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/80d8331b-4819-4aa9-9c7b-d6ce56708155.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYMIKEN86>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MYMIKEN86>>(v1);
    }

    // decompiled from Move bytecode v6
}

