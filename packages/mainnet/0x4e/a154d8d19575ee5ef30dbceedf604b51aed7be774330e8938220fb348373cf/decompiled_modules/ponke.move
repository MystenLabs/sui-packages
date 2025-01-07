module 0x4ea154d8d19575ee5ef30dbceedf604b51aed7be774330e8938220fb348373cf::ponke {
    struct PONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONKE>(arg0, 9, b"PONKE", b"Ponke", b"Ponke Ponke Ponke", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/227b30a4-4ed8-4bbb-8c07-d819a00821d7-AVT.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

