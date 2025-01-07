module 0x3d49e4af14b77310af0104cc875434c57068f677825c80e1f0a2c98224a18b83::foryou {
    struct FORYOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORYOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORYOU>(arg0, 9, b"FORYOU", b"Apocalypse", b"Safe the World ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/83b4f920-1898-4db3-84b9-5191bd9ac35d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORYOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FORYOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

