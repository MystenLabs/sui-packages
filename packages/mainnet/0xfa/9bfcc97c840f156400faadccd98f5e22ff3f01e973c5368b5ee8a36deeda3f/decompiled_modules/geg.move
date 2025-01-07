module 0xfa9bfcc97c840f156400faadccd98f5e22ff3f01e973c5368b5ee8a36deeda3f::geg {
    struct GEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEG>(arg0, 9, b"GEG", b"Ggdgdg", b"Vavag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f2fcc124-150f-4e27-a031-b8ca5a3bd12e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

