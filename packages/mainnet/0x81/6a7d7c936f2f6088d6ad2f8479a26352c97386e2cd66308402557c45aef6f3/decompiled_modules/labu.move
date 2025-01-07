module 0x816a7d7c936f2f6088d6ad2f8479a26352c97386e2cd66308402557c45aef6f3::labu {
    struct LABU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABU>(arg0, 6, b"LABU", b"Ambalabu", b"a mythical doll from ngawi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1471_81a4cca965.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LABU>>(v1);
    }

    // decompiled from Move bytecode v6
}

