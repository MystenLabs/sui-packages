module 0x6ae71b018ff9e7839b06c4cb958de2815f774fd808fa659dbae878e51d1642c9::suina {
    struct SUINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINA>(arg0, 6, b"SUINA", b"SUINA LADY DOG", b"SUINA IS BEAUTIFUL LADY DOG ON SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3980_51766be6ba.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

