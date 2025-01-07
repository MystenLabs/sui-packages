module 0x9dd94acbe874d7553aeac4d3543e42720b764d0109ee9d497336e26ba88f30aa::ajdkdmg {
    struct AJDKDMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AJDKDMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AJDKDMG>(arg0, 9, b"AJDKDMG", b"Wuwjjs", b"Sksjsk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/009a30e5-575e-4c0c-8ce7-fa328de952ed.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AJDKDMG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AJDKDMG>>(v1);
    }

    // decompiled from Move bytecode v6
}

