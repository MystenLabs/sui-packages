module 0xa30f3fabed3da37cea66864a4c3bdd3dbf1583745697ac203b8924738e02dde5::pooch {
    struct POOCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: POOCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POOCH>(arg0, 6, b"POOCH", b"Pochi", b"The most common dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_JN_Ba76_400x400_91d1d12860.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POOCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POOCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

