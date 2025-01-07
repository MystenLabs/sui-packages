module 0xde73db7eca815c4015e1175a845b65bae1d8a46fecbbbd93fdbb348e11d71ed9::turboscat {
    struct TURBOSCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOSCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOSCAT>(arg0, 6, b"TurbosCat", b"TurbosCat ", x"466972737420636174206f6e20547572626f732046756e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730965261780.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOSCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOSCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

