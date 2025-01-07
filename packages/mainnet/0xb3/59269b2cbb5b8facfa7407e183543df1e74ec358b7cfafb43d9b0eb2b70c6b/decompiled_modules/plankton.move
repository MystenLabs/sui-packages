module 0xb359269b2cbb5b8facfa7407e183543df1e74ec358b7cfafb43d9b0eb2b70c6b::plankton {
    struct PLANKTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLANKTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLANKTON>(arg0, 9, b"PLANKTON", b"PLTON", b"Plankton is Symbol Life Of wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c9e6834f-2212-4bbc-874c-9df3c4d9de8e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLANKTON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLANKTON>>(v1);
    }

    // decompiled from Move bytecode v6
}

