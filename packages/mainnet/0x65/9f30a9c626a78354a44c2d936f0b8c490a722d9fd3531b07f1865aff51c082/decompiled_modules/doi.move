module 0x659f30a9c626a78354a44c2d936f0b8c490a722d9fd3531b07f1865aff51c082::doi {
    struct DOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOI>(arg0, 9, b"DOI", b"DOGS INU", b"King of DOGS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0abbcf53-d242-43e5-9feb-1bc94819f19f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

