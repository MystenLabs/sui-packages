module 0x21f01019264b153e07b9e70119e7be909c0f8fb8e3e588a727a0940bc6900e13::nmad {
    struct NMAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NMAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NMAD>(arg0, 9, b"NMAD", b"nammo", b"AAAAZ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b49d857a-4515-4379-bc78-c25e255e77b8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NMAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NMAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

