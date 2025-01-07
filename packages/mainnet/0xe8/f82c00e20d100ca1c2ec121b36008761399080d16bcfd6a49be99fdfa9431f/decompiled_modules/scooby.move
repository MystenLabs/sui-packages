module 0xe8f82c00e20d100ca1c2ec121b36008761399080d16bcfd6a49be99fdfa9431f::scooby {
    struct SCOOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCOOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCOOBY>(arg0, 9, b"SCOOBY", b"Scoobert", b"Scooby-Doo is an American media franchise owned by Warner Bros.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9fb6af32-0ea1-4c4e-a979-15985ca743ce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCOOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCOOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

