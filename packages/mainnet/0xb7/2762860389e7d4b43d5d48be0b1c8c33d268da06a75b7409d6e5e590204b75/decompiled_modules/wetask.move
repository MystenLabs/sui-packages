module 0xb72762860389e7d4b43d5d48be0b1c8c33d268da06a75b7409d6e5e590204b75::wetask {
    struct WETASK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WETASK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WETASK>(arg0, 9, b"WETASK", b"WEWE task", b"This is for a task lol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1d047079-913c-41a5-b5d1-f7124e7e11f7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WETASK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WETASK>>(v1);
    }

    // decompiled from Move bytecode v6
}

