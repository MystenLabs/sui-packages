module 0x3ec81b1ce7c530276ca21188b34648b2ee87194776cfb59be3d4dc403ddf1514::niggas {
    struct NIGGAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGGAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGGAS>(arg0, 6, b"NIGGAS", b"NIGGAS DOG ON SUI", b"Just a dog named Nigga", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BOG_8abd8b829e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGGAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGGAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

