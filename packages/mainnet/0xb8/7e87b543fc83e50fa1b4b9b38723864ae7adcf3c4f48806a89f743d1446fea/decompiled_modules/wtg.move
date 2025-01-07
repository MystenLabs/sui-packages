module 0xb87e87b543fc83e50fa1b4b9b38723864ae7adcf3c4f48806a89f743d1446fea::wtg {
    struct WTG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTG>(arg0, 9, b"WTG", b"Warthog ", b"Created it for warthog lovers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/17766d10-f9cc-44ee-9389-a86e54e71dad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WTG>>(v1);
    }

    // decompiled from Move bytecode v6
}

