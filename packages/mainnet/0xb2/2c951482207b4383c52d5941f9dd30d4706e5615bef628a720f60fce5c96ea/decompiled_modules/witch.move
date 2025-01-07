module 0xb22c951482207b4383c52d5941f9dd30d4706e5615bef628a720f60fce5c96ea::witch {
    struct WITCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WITCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WITCH>(arg0, 9, b"WITCH", x"46554c4ce280a24d4f4f4e", b"A fun token for Taproot Witches ordinal lovers ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/50ab474d-d23c-43a5-a3e7-33c3897359a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WITCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WITCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

