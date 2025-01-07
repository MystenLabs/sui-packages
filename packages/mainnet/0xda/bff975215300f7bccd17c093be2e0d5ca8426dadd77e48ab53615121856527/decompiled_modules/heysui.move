module 0xdabff975215300f7bccd17c093be2e0d5ca8426dadd77e48ab53615121856527::heysui {
    struct HEYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEYSUI>(arg0, 9, b"HEYSUI", b"Heysuisui", b"Heysuisui number one", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f0e1c34b-ffcf-435d-8eb8-0c26775d4d86.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

