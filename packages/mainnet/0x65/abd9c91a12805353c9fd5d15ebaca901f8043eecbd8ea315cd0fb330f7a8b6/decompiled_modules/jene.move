module 0x65abd9c91a12805353c9fd5d15ebaca901f8043eecbd8ea315cd0fb330f7a8b6::jene {
    struct JENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JENE>(arg0, 9, b"JENE", b"hend", b"jend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/65f7ae4e-fa23-4a96-87e7-b8f256bd2c98.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JENE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JENE>>(v1);
    }

    // decompiled from Move bytecode v6
}

