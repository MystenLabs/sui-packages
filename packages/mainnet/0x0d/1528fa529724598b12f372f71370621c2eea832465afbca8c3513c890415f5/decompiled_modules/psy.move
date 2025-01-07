module 0xd1528fa529724598b12f372f71370621c2eea832465afbca8c3513c890415f5::psy {
    struct PSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSY>(arg0, 9, b"PSY", b"PSYDUCK", b"QUACK-QUACK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/245b7cf3-4252-4b42-be78-cbb1f816c0d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

