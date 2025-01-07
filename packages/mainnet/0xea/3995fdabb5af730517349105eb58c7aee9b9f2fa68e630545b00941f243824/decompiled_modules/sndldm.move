module 0xea3995fdabb5af730517349105eb58c7aee9b9f2fa68e630545b00941f243824::sndldm {
    struct SNDLDM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNDLDM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNDLDM>(arg0, 9, b"SNDLDM", b"Syejwn", b"Smdkgmv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bccd8850-808a-4995-8b59-a1abbc526fd4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNDLDM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNDLDM>>(v1);
    }

    // decompiled from Move bytecode v6
}

