module 0xffee377ea6e630164f9a80a0cd19532434737ae057c16f4549f86ab912e2c4fe::notscam {
    struct NOTSCAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTSCAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTSCAM>(arg0, 9, b"NOTSCAM", b"notscam", b"Only for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c686371b-fd99-4637-9f37-476e029b6eac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTSCAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOTSCAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

