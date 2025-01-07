module 0xf53c80eb4c58b1221f756838e1c11ce1dc569f8701d1d3ad2382e5a36073c9f4::agti {
    struct AGTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGTI>(arg0, 9, b"AGTI", b"AGENT AI", b"AGENT FORCE AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c6398b3-a32b-4309-a53e-4f15a09411a2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

