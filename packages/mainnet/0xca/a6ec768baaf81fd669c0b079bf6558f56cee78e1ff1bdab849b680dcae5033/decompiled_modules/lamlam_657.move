module 0xcaa6ec768baaf81fd669c0b079bf6558f56cee78e1ff1bdab849b680dcae5033::lamlam_657 {
    struct LAMLAM_657 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMLAM_657, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMLAM_657>(arg0, 9, b"LAMLAM_657", b"lamlam", b"no", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/11d7339e-baf4-4b98-82cd-f53beaa25536.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMLAM_657>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAMLAM_657>>(v1);
    }

    // decompiled from Move bytecode v6
}

