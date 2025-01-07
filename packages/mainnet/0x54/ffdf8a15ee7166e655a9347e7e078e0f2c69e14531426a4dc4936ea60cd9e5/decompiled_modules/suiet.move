module 0x54ffdf8a15ee7166e655a9347e7e078e0f2c69e14531426a4dc4936ea60cd9e5::suiet {
    struct SUIET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIET>(arg0, 6, b"SUIET", b"Suieet", b"The Sweetest  Memecoin on #SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_8c937abd68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIET>>(v1);
    }

    // decompiled from Move bytecode v6
}

