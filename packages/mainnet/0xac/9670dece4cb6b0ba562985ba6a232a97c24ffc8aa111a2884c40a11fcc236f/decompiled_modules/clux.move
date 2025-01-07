module 0xac9670dece4cb6b0ba562985ba6a232a97c24ffc8aa111a2884c40a11fcc236f::clux {
    struct CLUX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLUX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLUX>(arg0, 9, b"CLUX", b"CARCOIN", b"The ultimate pleasure in the world of meme coins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c2638416-02d7-4f27-9744-7cf80a05f240.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLUX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLUX>>(v1);
    }

    // decompiled from Move bytecode v6
}

