module 0xfa20229f66dabee77d18baf5833de3dccaae7ccbe50072c53556f92cace7cd58::shibamoon {
    struct SHIBAMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBAMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBAMOON>(arg0, 6, b"SHIBAMOON", b"ASTEROID SHIBA", b"LETS TAKE SHIBA ON HIS ASTEROID TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ASTEROID_TTQ_9kk_ZDA_Sh_Bp0_Xb0y_6a8ffd44fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBAMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBAMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

