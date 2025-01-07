module 0x677891b0c1f51262c1b1a878df4f4e7f43c551bda4c8597e9cff7b1533373091::ber {
    struct BER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BER>(arg0, 9, b"BER", b"beach", b"A place to sunbathe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a0c50728-7902-4cf6-a613-be3adaf5fd1a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BER>>(v1);
    }

    // decompiled from Move bytecode v6
}

