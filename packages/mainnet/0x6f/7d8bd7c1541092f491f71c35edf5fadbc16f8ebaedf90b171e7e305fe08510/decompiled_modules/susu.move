module 0x6f7d8bd7c1541092f491f71c35edf5fadbc16f8ebaedf90b171e7e305fe08510::susu {
    struct SUSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSU>(arg0, 9, b"SUSU", b"BBSuSu", b"my baby love", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fab2715a-9b00-40f1-8dbe-467b474b952a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

