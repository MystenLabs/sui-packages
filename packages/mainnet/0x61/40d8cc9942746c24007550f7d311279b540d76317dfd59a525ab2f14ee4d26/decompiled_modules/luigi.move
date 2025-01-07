module 0x6140d8cc9942746c24007550f7d311279b540d76317dfd59a525ab2f14ee4d26::luigi {
    struct LUIGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUIGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUIGI>(arg0, 6, b"LUIGI", b"LUIGI SUI", b"LUIGI ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6562_fcc3338ae8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUIGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUIGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

