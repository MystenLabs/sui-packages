module 0x8745f6e6dddc797f0cf2f030201bcc97f3d1218d45dbfd7e400e11ac444bff37::kung {
    struct KUNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUNG>(arg0, 6, b"KUNG", b"Kung on Sui", b"The Only $KUNG on Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055647_7e6eb3f2d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

