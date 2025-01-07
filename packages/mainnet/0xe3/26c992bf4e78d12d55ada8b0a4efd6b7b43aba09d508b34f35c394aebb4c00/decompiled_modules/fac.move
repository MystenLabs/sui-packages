module 0xe326c992bf4e78d12d55ada8b0a4efd6b7b43aba09d508b34f35c394aebb4c00::fac {
    struct FAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAC>(arg0, 6, b"FAC", b"FlyingAvoCat", b"No Twitter no socials let it fly then watch it die", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/21_D27_C6_C_eab82f10d0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

