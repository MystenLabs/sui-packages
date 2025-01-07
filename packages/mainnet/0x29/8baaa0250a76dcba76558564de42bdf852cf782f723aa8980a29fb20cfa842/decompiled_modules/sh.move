module 0x298baaa0250a76dcba76558564de42bdf852cf782f723aa8980a29fb20cfa842::sh {
    struct SH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SH>(arg0, 9, b"SH", b"Shin", b"Dep trai ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3d834567-bc15-4425-84d1-ec56658cda10.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SH>>(v1);
    }

    // decompiled from Move bytecode v6
}

