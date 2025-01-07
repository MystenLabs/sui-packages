module 0xa618ffbeb2125fd507b687a22e71339ba86cf6e3b73b533e66f73fcc82eb7eb::hepoo {
    struct HEPOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEPOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEPOO>(arg0, 9, b"HEPOO", b"Baby hepo", b"Bay hepoo and  grow hipo community this hepo mother is death alone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9bc7fb20-a3ff-40a4-84b4-4dc887916c32.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEPOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEPOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

