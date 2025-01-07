module 0xe2943898e6eaaade9d1b64691a2582d1fa7754e8275c39bf79491cd5de31684e::twifh {
    struct TWIFH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWIFH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWIFH>(arg0, 6, b"TWIFH", b"TURTLE WIF HAT", b"Literally just a cute little turtle wif a beautiful hat!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F_Tu_Ds1v1_400x400_f3f403e035.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWIFH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWIFH>>(v1);
    }

    // decompiled from Move bytecode v6
}

