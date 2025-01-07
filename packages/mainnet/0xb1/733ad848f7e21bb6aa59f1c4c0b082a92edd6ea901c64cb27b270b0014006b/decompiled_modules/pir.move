module 0xb1733ad848f7e21bb6aa59f1c4c0b082a92edd6ea901c64cb27b270b0014006b::pir {
    struct PIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIR>(arg0, 9, b"PIR", b"DISSA PIR", b"DI SSA PIR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2e5c4452-1422-47c4-84ba-eed54b78c34d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

