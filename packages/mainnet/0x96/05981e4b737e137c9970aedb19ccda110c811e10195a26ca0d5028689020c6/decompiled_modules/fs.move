module 0x9605981e4b737e137c9970aedb19ccda110c811e10195a26ca0d5028689020c6::fs {
    struct FS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FS>(arg0, 9, b"FS", b"winnie", b"female shiba", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1443134a-2bcb-4be5-a476-e60dce48e4e7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FS>>(v1);
    }

    // decompiled from Move bytecode v6
}

