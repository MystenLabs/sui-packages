module 0x657b935b5aff6900fbc1b3186a6649bdc7d0db46e6425ea323e6ef7cf9fa0712::egg {
    struct EGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGG>(arg0, 6, b"EGG", b"EggSui", b"$EGG is the only currency older than Gold ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/EGG_abc1337f0a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

