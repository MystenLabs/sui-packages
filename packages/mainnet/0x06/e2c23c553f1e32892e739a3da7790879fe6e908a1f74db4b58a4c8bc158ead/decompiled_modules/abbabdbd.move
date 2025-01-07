module 0x6e2c23c553f1e32892e739a3da7790879fe6e908a1f74db4b58a4c8bc158ead::abbabdbd {
    struct ABBABDBD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABBABDBD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABBABDBD>(arg0, 9, b"ABBABDBD", b"Abdvdv", b"Hdshsbbs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7815787f-8bf4-4aca-8b0e-39e8e580a316.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABBABDBD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABBABDBD>>(v1);
    }

    // decompiled from Move bytecode v6
}

