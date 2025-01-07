module 0xda5277f6237974c406578b6502f804f2530bc26147a4455ac29f6e02a78039aa::fl {
    struct FL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FL>(arg0, 9, b"FL", b"Florida", b"Rescue team ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f98bacc0-723f-4fde-ba12-642773d39e65.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FL>>(v1);
    }

    // decompiled from Move bytecode v6
}

