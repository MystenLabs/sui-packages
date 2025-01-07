module 0x9d2476c696f045779bc16bc195fa4922bc82f8a0d563141b0055be2a12ded93::dfz {
    struct DFZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFZ>(arg0, 9, b"DFZ", b"KJHSD", b"BBCC ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d81e4fe2-b605-4f5a-aff0-e7e0cd229a10.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

