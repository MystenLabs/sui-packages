module 0x49744e25fd654709f43266e2c6336b661b6843762ce5e73f9e52e126c5804ca6::jlo {
    struct JLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JLO>(arg0, 9, b"JLO", b"jallo", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a8f732c2-1c71-4779-b0ff-b2ec3b5f9e66.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

