module 0xb6e69d2a10cd3334f029bfafea392a88c212d8e3826ab0fd87f2584becc167d3::meow {
    struct MEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOW>(arg0, 6, b"MEOW", b"Me End Own Will", b"$MEOW , One day, sheltering from a rainstorm, Meow stumbled onto the Ethereum blockchain. Intrigued by it's complexities and opportunity, he was hooked.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8w_ZLKOTR_400x400_2332d2be2d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEOW>>(v1);
    }

    // decompiled from Move bytecode v6
}

