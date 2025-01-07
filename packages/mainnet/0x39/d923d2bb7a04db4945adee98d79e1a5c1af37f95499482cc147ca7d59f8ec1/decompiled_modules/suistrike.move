module 0x39d923d2bb7a04db4945adee98d79e1a5c1af37f95499482cc147ca7d59f8ec1::suistrike {
    struct SUISTRIKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISTRIKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISTRIKE>(arg0, 6, b"SuiStrike", b"BUILDERs", b"We are building to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bunny_59c3d1db14.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTRIKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISTRIKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

