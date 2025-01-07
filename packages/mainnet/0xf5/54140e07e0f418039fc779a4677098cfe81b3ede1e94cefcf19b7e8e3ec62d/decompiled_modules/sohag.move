module 0xf554140e07e0f418039fc779a4677098cfe81b3ede1e94cefcf19b7e8e3ec62d::sohag {
    struct SOHAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOHAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOHAG>(arg0, 9, b"SOHAG", b"SH", b"I love crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0817958e-6730-4e4f-b638-da6894399229.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOHAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOHAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

