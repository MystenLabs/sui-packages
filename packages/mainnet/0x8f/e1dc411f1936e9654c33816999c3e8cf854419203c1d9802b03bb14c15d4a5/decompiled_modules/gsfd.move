module 0x8fe1dc411f1936e9654c33816999c3e8cf854419203c1d9802b03bb14c15d4a5::gsfd {
    struct GSFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSFD>(arg0, 9, b"GSFD", b"FDHD", b"SCG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5031130d-2422-44cc-b8ee-6f60165f785f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GSFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

