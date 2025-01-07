module 0x2c57f22758036b7244823f223765b2b064ebbfe9c5e7ccd8cfc04a162579f9cc::mdr {
    struct MDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDR>(arg0, 9, b"MDR", b"madura", b"tradisi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0e029930-91f2-4909-a6ea-41fece612fb0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDR>>(v1);
    }

    // decompiled from Move bytecode v6
}

