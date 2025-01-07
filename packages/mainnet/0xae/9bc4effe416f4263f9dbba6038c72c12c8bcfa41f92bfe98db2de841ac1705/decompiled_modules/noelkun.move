module 0xae9bc4effe416f4263f9dbba6038c72c12c8bcfa41f92bfe98db2de841ac1705::noelkun {
    struct NOELKUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOELKUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOELKUN>(arg0, 9, b"NOELKUN", b"Noelkun", b"A cute doggy owned by Nanomew", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/888ee37e-4f1e-4e7c-908f-44f4bfc85753.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOELKUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOELKUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

