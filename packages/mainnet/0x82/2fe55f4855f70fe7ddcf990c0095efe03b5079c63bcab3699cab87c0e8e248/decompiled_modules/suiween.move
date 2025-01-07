module 0x822fe55f4855f70fe7ddcf990c0095efe03b5079c63bcab3699cab87c0e8e248::suiween {
    struct SUIWEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWEEN>(arg0, 6, b"SUIWEEN", b"Suiween", b"Happy Suiween! suiween.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_Ay_Z6nou_400x400_15e7064e03.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWEEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

