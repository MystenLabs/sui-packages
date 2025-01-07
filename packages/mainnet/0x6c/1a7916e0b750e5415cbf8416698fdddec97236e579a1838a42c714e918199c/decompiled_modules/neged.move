module 0x6c1a7916e0b750e5415cbf8416698fdddec97236e579a1838a42c714e918199c::neged {
    struct NEGED has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEGED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEGED>(arg0, 9, b"NEGED", b"DEGEN", b"Let's have it on sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/af9974a4-c147-4f12-85f9-d8a8f5beff63.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEGED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEGED>>(v1);
    }

    // decompiled from Move bytecode v6
}

