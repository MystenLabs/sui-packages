module 0xd38cd084c04cde1f8a1addf1a7038c103f162240b27dd1a76b83bad383bbd52a::skurack {
    struct SKURACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKURACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKURACK>(arg0, 6, b"SKURACK", b"Skull Crack", b"Kenny ackerman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8b2445284e7f3793c00c4cc657c54ff2_40c60aa390.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKURACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKURACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

