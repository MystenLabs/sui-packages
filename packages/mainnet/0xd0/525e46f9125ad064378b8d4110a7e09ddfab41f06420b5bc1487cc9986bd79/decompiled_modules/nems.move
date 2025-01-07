module 0xd0525e46f9125ad064378b8d4110a7e09ddfab41f06420b5bc1487cc9986bd79::nems {
    struct NEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEMS>(arg0, 9, b"NEMS", b"Games", b"Games token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c6695341-e9a0-488d-a8ef-fd1fd2a0e553.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

