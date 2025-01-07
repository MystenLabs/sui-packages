module 0x672baa18b06ab84d67165fbeed89d698440af1c454ea47bfe35541e4b26e5919::gfdg {
    struct GFDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GFDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFDG>(arg0, 9, b"GFDG", b"HEH", b"DSF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/55ec310a-c529-4691-833d-4e64cea26249.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GFDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GFDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

