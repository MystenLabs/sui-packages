module 0x2fbbe6c27be0a42e37d5c9332c056755a51f90142da14d1bd22702081b78c5a3::suni {
    struct SUNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNI>(arg0, 6, b"Suni", b"Suni Token", b"Suni Sui Life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/st_d0171cf211.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNI>>(v1);
    }

    // decompiled from Move bytecode v6
}

