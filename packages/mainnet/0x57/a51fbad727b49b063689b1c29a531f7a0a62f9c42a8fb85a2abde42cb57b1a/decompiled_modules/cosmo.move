module 0x57a51fbad727b49b063689b1c29a531f7a0a62f9c42a8fb85a2abde42cb57b1a::cosmo {
    struct COSMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COSMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COSMO>(arg0, 9, b"COSMO", b"Cosmodrom ", b"The \"Universal Cosmodrome\" token is a unique digital asset that provides its owners with access to exclusive opportunities and benefits. It was developed to stimulate the development of the space industry and attract investment in this area.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/06df06c8-7676-415b-8b27-867d7a23b507.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COSMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COSMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

