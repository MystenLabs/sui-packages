module 0x81894b2664177929a08a95572594c9a6f6eeca5c7929f485b79bc62aedca6a7c::memeois {
    struct MEMEOIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEOIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEOIS>(arg0, 9, b"MEMEOIS", b"Memeoi", b"THAT GO I HE SHE IT WHAT HE WHEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c72557f4-2dc9-46bb-a856-d81f50ca655d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEOIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEOIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

