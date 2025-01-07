module 0x2e7678ece1b7f15d1795fa1eb804fbe40f8b90a82280a4bb3ab18eb16f253c25::marvin {
    struct MARVIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARVIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARVIN>(arg0, 6, b"MARVIN", b"Marvin On Sui", b"MarVin's Big Adventure Starts Here!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/marvin_the_fluffy_dog_psyco_10_300x226_3353d02ecb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARVIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARVIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

