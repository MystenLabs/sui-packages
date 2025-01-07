module 0x63ca823e0396bb9f722a1624f29b511ad3b8fc5e7af17ee33532f4b87da36ec0::clsui {
    struct CLSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLSUI>(arg0, 9, b"CLSUI", b"COOLSUI", b"COOLSUI (CSL) is a revolutionary utility token designed to empower users within the Sui ecosystem. CSL facilitates seamless interactions, enables decentralized applications, and rewards contributors.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d022e962-034d-44de-9efa-1840fa31dfa7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

