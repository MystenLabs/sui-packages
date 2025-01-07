module 0x44562dd4e3aaa5cdd8fed25d20445a339fba0232a8ab38372e1091fbe47486dd::e40 {
    struct E40 has drop {
        dummy_field: bool,
    }

    fun init(arg0: E40, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<E40>(arg0, 9, b"E40", b"Dank", b"Just cool meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bcac5a45-40f7-4d25-8da2-66ca51106099.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<E40>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<E40>>(v1);
    }

    // decompiled from Move bytecode v6
}

