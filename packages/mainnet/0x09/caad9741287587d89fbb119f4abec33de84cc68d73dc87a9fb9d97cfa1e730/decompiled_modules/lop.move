module 0x9caad9741287587d89fbb119f4abec33de84cc68d73dc87a9fb9d97cfa1e730::lop {
    struct LOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOP>(arg0, 9, b"LOP", b"lop", b"hello im here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/4d272462-a269-4bf0-8cde-4b6c843e5cce.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

