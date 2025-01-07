module 0x21a1535e912a7feaa68931e3bb62e2fb0a609223d8fdf7414cd5c434c932ea38::nsi {
    struct NSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSI>(arg0, 9, b"NSI", b"Notsui", b"Notsui not pixel", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8097b6a5-fdeb-46e7-9e2e-248e92897762.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

