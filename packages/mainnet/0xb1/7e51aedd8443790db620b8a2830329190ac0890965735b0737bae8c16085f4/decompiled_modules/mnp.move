module 0xb17e51aedd8443790db620b8a2830329190ac0890965735b0737bae8c16085f4::mnp {
    struct MNP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNP>(arg0, 9, b"MNP", b"MOONPUMP ", b"To the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed47c396-a04c-4eb6-9ee0-cbbf781ae55d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MNP>>(v1);
    }

    // decompiled from Move bytecode v6
}

