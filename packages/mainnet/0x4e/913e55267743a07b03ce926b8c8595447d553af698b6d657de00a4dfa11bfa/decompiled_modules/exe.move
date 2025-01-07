module 0x4e913e55267743a07b03ce926b8c8595447d553af698b6d657de00a4dfa11bfa::exe {
    struct EXE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXE>(arg0, 9, b"EXE", b"Exegang", b"Sh!t coin for university student", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dee4cae7-8b5f-46d7-8d61-c3fb614a1a74.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EXE>>(v1);
    }

    // decompiled from Move bytecode v6
}

