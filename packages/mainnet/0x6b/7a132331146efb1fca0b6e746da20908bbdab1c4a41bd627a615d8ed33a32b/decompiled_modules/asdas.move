module 0x6b7a132331146efb1fca0b6e746da20908bbdab1c4a41bd627a615d8ed33a32b::asdas {
    struct ASDAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDAS>(arg0, 9, b"ASDAS", b"fgfg", b"DGFH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cb9b9098-f624-4ece-8eee-9cff0a3f7f13.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASDAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

