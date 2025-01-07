module 0x7752da4c0282fb9604682d2b839890d9974e326906df9bb8a5869abd8c255fc5::pn {
    struct PN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PN>(arg0, 9, b"PN", b"Poin", b"Trading Buy Hold ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fd782de2-45a3-448d-892f-e89cbaa63edd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PN>>(v1);
    }

    // decompiled from Move bytecode v6
}

