module 0x7e97dc313801114afef4abd2e5f90cf155d495b187c84e51940b86034cd1ad5a::pa {
    struct PA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PA>(arg0, 9, b"PA", b"Prana", b"Life", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/055b9744-ef4c-4c39-9313-c8cff0f4aa0a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PA>>(v1);
    }

    // decompiled from Move bytecode v6
}

