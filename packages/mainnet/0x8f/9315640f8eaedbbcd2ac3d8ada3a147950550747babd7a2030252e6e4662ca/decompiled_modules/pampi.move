module 0x8f9315640f8eaedbbcd2ac3d8ada3a147950550747babd7a2030252e6e4662ca::pampi {
    struct PAMPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAMPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAMPI>(arg0, 9, b"PAMPI", b"Pampi", b"Inspried by Disney cartoon deer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/42669b1f-098a-44f5-ae78-33b476ed3ffe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAMPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAMPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

