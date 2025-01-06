module 0xc6dc9dd83fbf3d16554477f00393966ac2480a08b70dcba051c543b54894fa50::jew {
    struct JEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEW>(arg0, 9, b"JEW", b"BADIEE", b"BADIEEJEWELERY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f3e17ef9-6d73-4176-ab34-0adbd700d74a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

