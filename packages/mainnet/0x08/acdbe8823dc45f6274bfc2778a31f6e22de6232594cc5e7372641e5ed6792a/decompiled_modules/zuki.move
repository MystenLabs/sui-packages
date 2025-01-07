module 0x8acdbe8823dc45f6274bfc2778a31f6e22de6232594cc5e7372641e5ed6792a::zuki {
    struct ZUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUKI>(arg0, 6, b"ZUKI", b"Suizuki", b"fast chain needs fast car $ZUKI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ea0_YX_3_v_400x400_c4e9f33918.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

