module 0xdfdb34e9ceac51f269f104fbbd7582675297686a8f144dc5a31e1065742c0f7f::sde {
    struct SDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDE>(arg0, 9, b"SDE", b"SKY", b"THE SKY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce9457cc-0e06-4544-823a-0cd2c32ff808.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

