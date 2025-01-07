module 0x577e28335f6dddf9d4622ebd911ac13ab9095e1663b39545c5bcac35d76319b::kwb {
    struct KWB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KWB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KWB>(arg0, 9, b"KWB", b"Kurwa bobe", b"Kurwa bober mem token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/071df5fd-db5b-4de3-a2ba-200441d25f78.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KWB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KWB>>(v1);
    }

    // decompiled from Move bytecode v6
}

