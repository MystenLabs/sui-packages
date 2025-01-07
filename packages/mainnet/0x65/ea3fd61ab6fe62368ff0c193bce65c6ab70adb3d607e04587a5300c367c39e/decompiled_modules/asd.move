module 0x65ea3fd61ab6fe62368ff0c193bce65c6ab70adb3d607e04587a5300c367c39e::asd {
    struct ASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASD>(arg0, 9, b"ASD", b"ASDAS", b"CZXCZ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ea3058a6-d489-4eb4-bd56-816753bffe09.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASD>>(v1);
    }

    // decompiled from Move bytecode v6
}

