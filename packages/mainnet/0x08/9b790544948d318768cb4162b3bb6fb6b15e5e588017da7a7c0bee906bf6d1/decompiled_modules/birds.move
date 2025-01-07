module 0x89b790544948d318768cb4162b3bb6fb6b15e5e588017da7a7c0bee906bf6d1::birds {
    struct BIRDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDS>(arg0, 9, b"BIRDS", b"Sparrow ", b"This coin is created by serve the injured birds to protect the environment ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/be0b2c22-dc53-4bda-85bb-daf130d59bb7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIRDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

