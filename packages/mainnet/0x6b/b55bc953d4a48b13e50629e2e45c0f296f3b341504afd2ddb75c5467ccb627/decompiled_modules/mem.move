module 0x6bb55bc953d4a48b13e50629e2e45c0f296f3b341504afd2ddb75c5467ccb627::mem {
    struct MEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEM>(arg0, 9, b"MEM", b"Gm", b"Hi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b4738935-eba5-45bc-beaa-49374ecb47e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

