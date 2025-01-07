module 0xc7f947589795a4fdb17db6888080a1c00dd19872c9e4dda789432309531edeab::nwr {
    struct NWR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NWR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NWR>(arg0, 9, b"NWR", b"Nwork", b"Wow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b3e08c03-5add-4a6a-99cc-7c56266cc38e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NWR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NWR>>(v1);
    }

    // decompiled from Move bytecode v6
}

