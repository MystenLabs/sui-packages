module 0xb57a6bd740a0b5f3fb963fc77a22564873ebcac1c1ab7f2679f0d67f46de9f1c::dnsnnf {
    struct DNSNNF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNSNNF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNSNNF>(arg0, 9, b"DNSNNF", b"Syajan", b"Dndmmdn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8b8027bb-7189-4880-9536-fdcd15197805.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNSNNF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DNSNNF>>(v1);
    }

    // decompiled from Move bytecode v6
}

