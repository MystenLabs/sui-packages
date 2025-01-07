module 0xfb8b9a619743f8e5d8b2953df1072e5d3c17d276c46b932b9b2823eaa71edb1a::trump4724 {
    struct TRUMP4724 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP4724, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP4724>(arg0, 9, b"TRUMP4724", b"Trump2024", b"Meme about America President 47th", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/46ac8384-850e-4eab-aea9-aa06580e84af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP4724>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP4724>>(v1);
    }

    // decompiled from Move bytecode v6
}

