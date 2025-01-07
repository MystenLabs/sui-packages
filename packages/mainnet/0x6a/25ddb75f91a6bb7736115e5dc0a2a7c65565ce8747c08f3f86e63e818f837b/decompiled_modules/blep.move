module 0x6a25ddb75f91a6bb7736115e5dc0a2a7c65565ce8747c08f3f86e63e818f837b::blep {
    struct BLEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLEP>(arg0, 6, b"BLEP", b"Blep Cat", b"Blep Cat Coin is the next-generation memecoin inspired by the Internets favorite phenomenon: the adorable, tongue-out blep expression cats make!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000019072_6844f8d735.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

