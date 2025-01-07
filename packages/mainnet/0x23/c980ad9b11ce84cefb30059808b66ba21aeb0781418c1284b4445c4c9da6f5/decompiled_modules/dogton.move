module 0x23c980ad9b11ce84cefb30059808b66ba21aeb0781418c1284b4445c4c9da6f5::dogton {
    struct DOGTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGTON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGTON>(arg0, 9, b"DOGTON", b"Dogeton", b"At its heart, Dogecoin is the accidental crypto movement that makes people smile!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d3ca90cd-92c6-4c63-9a99-ce42854b2e20-images (4).jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGTON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGTON>>(v1);
    }

    // decompiled from Move bytecode v6
}

