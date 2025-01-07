module 0x1062739bd45920118bc17eded7d9e96556e2b376ce91694242954a45e89a374b::slapsui {
    struct SLAPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLAPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLAPSUI>(arg0, 9, b"SLAPSUI", b"SLAP", x"534c41502069732061206d656d6520636f696e206275696c74206f6e2073756920426c6f636b636861696e20746563686e6f6c6f677920f09f918bf09f988a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8e9405e9-78b1-42aa-89bc-3c393df816b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLAPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLAPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

