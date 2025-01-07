module 0x29f475c9e3e6261681b49448cb7058e19c396174fc597b3f6fc5342112f87802::bluiy {
    struct BLUIY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUIY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUIY>(arg0, 6, b"BLUIY", b"Bluiy The Cat", b"Hi My Name Is Bluiy. I'm So Cute ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bluiy_the_cat_67c215a66c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUIY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUIY>>(v1);
    }

    // decompiled from Move bytecode v6
}

