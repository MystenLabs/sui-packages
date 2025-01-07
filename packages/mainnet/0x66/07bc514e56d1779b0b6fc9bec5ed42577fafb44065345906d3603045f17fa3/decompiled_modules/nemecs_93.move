module 0x6607bc514e56d1779b0b6fc9bec5ed42577fafb44065345906d3603045f17fa3::nemecs_93 {
    struct NEMECS_93 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEMECS_93, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEMECS_93>(arg0, 9, b"NEMECS_93", b"Nemecs", b"For fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a75b94c8-bad4-4a59-ac62-f19d2a3e7eac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEMECS_93>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEMECS_93>>(v1);
    }

    // decompiled from Move bytecode v6
}

