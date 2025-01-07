module 0x7d7aa205c3dda83e8a2819fe5a6fa87757a637624ae1df0d90fb13347f414628::dguaubg {
    struct DGUAUBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGUAUBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGUAUBG>(arg0, 9, b"DGUAUBG", b"Dragon3388", b"Gm good products jdgabgyx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6570a799-71ad-4489-9606-d33cc7b85b5c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGUAUBG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGUAUBG>>(v1);
    }

    // decompiled from Move bytecode v6
}

