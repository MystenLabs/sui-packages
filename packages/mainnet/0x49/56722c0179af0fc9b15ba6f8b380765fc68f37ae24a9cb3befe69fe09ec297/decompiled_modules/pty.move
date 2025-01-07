module 0x4956722c0179af0fc9b15ba6f8b380765fc68f37ae24a9cb3befe69fe09ec297::pty {
    struct PTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTY>(arg0, 9, b"PTY", b"PATTY", b"It's a community project created for meme token awareness", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8b66b4a4-ab73-40fc-bf10-e696b847ba41.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

