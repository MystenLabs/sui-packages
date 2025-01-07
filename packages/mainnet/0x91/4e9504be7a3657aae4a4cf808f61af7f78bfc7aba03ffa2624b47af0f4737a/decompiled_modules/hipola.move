module 0x914e9504be7a3657aae4a4cf808f61af7f78bfc7aba03ffa2624b47af0f4737a::hipola {
    struct HIPOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPOLA>(arg0, 9, b"HIPOLA", b"LETE", b"Good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/54ba1194-16f7-44f0-b9c8-d64f3943692e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIPOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

