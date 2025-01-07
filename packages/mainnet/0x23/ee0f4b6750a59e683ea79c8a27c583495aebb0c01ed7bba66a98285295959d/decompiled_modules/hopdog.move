module 0x23ee0f4b6750a59e683ea79c8a27c583495aebb0c01ed7bba66a98285295959d::hopdog {
    struct HOPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPDOG>(arg0, 6, b"Hopdog", b"HopDog", b"$HOPDOG, Sui's and Hop's best dog! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hopdog_d0a12fccc6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

