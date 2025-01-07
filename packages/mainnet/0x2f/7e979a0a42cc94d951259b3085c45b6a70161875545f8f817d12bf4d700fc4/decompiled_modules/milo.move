module 0x2f7e979a0a42cc94d951259b3085c45b6a70161875545f8f817d12bf4d700fc4::milo {
    struct MILO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILO>(arg0, 9, b"MILO", b"Milo (sui)", b"cute cats in cyberspace", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e0e4dfbc-d008-4f87-8c18-2eb85e7d67d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MILO>>(v1);
    }

    // decompiled from Move bytecode v6
}

