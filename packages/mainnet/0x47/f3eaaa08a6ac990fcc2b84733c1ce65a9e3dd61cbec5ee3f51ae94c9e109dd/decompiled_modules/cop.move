module 0x47f3eaaa08a6ac990fcc2b84733c1ce65a9e3dd61cbec5ee3f51ae94c9e109dd::cop {
    struct COP has drop {
        dummy_field: bool,
    }

    fun init(arg0: COP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COP>(arg0, 6, b"COP", b"Coked Out Pepe", b"Wild, unstoppable, Pepe-fueled chaos to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2552_e5a7c74129.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COP>>(v1);
    }

    // decompiled from Move bytecode v6
}

