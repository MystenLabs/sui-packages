module 0x2033428c1e7578ad00d2b26fcfba4cb16fa8d8265e8645af2cedabe7c05fe76c::pcat {
    struct PCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCAT>(arg0, 6, b"Pcat", b"popcat", b"This was the poop of cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731309381685.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

