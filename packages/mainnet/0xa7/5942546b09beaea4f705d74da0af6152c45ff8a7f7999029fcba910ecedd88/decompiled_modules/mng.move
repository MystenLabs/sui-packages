module 0xa75942546b09beaea4f705d74da0af6152c45ff8a7f7999029fcba910ecedd88::mng {
    struct MNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNG>(arg0, 9, b"MNG", b"Meong", b"Moeng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/20ef9482-166d-4331-9f4d-9fbddc28d938.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

