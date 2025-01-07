module 0xb68bd4390671751a92a86feb4be9d5ae66b295f44805a57089ce5f94a8cec7c9::wewemoon {
    struct WEWEMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEWEMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEWEMOON>(arg0, 9, b"WEWEMOON", b"Moon", b"No1 to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fcab0ba8-d3c1-41a0-bcbb-ac8a15b3d3e8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEWEMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEWEMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

