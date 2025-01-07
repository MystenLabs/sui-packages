module 0xd10a68d8c2e9e7fdf5512a04aed9f2c1839d6c10349872ea365f06ca18fc3cd1::piz {
    struct PIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIZ>(arg0, 9, b"PIZ", b"Pizza", b"Only token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7940191a-cd02-4c52-85c5-24ef0f887b53.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

