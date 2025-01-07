module 0xb51cdec4dcdc34841271c4ee9f0ba9961b8d47b13a52e4c715bbd70bcfe40d22::sw {
    struct SW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SW>(arg0, 9, b"SW", b"Sand ", b"I have to be honest ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/15442e28-0f8a-4de9-a8fc-ddeb5084943e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SW>>(v1);
    }

    // decompiled from Move bytecode v6
}

