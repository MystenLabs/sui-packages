module 0xf03b1ad96dd541efaeb443f2a996ffa287241c1ab1ff4d0f548598b1e635a025::van {
    struct VAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAN>(arg0, 9, b"VAN", b"VanC", b"Vehical coin for community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e82aebad-8d12-4786-b9ba-4de62a50818a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

