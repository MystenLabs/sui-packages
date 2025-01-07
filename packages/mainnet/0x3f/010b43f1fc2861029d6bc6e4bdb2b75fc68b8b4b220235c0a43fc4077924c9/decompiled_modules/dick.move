module 0x3f010b43f1fc2861029d6bc6e4bdb2b75fc68b8b4b220235c0a43fc4077924c9::dick {
    struct DICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DICK>(arg0, 9, b"DICK", b"Lil Dicky", b"as men we are proud to have a dick", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/219c7664-eb6c-44d7-8962-f82253f1489c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

