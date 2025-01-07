module 0x20021de40c7498351079e4f42101be74f3c0d9acc1537467fd6bf42997abde4b::sjepit {
    struct SJEPIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJEPIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJEPIT>(arg0, 9, b"SJEPIT", b"Sendal", b"This token was inspired by my daily sandals at home that never change shape over the year", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e35c27de-ed90-49e9-aca2-1669cde30b91.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJEPIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SJEPIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

