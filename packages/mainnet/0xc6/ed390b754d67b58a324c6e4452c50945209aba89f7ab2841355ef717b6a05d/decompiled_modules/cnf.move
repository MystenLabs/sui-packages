module 0xc6ed390b754d67b58a324c6e4452c50945209aba89f7ab2841355ef717b6a05d::cnf {
    struct CNF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CNF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CNF>(arg0, 9, b"CNF", b"CONFRA", b"It's a promising token to invest in ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bb95c842-aa50-43e6-b050-f4f8733f0109.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CNF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CNF>>(v1);
    }

    // decompiled from Move bytecode v6
}

