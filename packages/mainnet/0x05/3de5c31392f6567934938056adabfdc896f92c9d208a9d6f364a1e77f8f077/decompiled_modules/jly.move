module 0x53de5c31392f6567934938056adabfdc896f92c9d208a9d6f364a1e77f8f077::jly {
    struct JLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JLY>(arg0, 9, b"JLY", b"Jelly ", b"Jelly are the cutest animals in the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f3a44ec8-817a-47ab-80f0-c6f68d1468b2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

