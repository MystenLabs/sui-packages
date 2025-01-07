module 0xc21753a4986ba385e8b92cb5ae27ae4b49a1443aea318cbc863c5be9db9d86f3::dogo {
    struct DOGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGO>(arg0, 6, b"DOGO", b"Dogo", b"$DOGO is the coolest dog on the Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ppp_0462ca5d4e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

