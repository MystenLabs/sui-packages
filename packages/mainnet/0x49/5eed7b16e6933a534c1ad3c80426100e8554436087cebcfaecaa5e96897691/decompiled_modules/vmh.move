module 0x495eed7b16e6933a534c1ad3c80426100e8554436087cebcfaecaa5e96897691::vmh {
    struct VMH has drop {
        dummy_field: bool,
    }

    fun init(arg0: VMH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VMH>(arg0, 9, b"VMH", b"VMHOOANGIT", b"vmhoangit1408", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c856f9f9-82ee-4fb7-9170-819325bc455a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VMH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VMH>>(v1);
    }

    // decompiled from Move bytecode v6
}

