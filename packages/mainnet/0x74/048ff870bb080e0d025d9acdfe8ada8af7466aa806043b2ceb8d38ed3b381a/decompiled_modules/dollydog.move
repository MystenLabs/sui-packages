module 0x74048ff870bb080e0d025d9acdfe8ada8af7466aa806043b2ceb8d38ed3b381a::dollydog {
    struct DOLLYDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLLYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLLYDOG>(arg0, 6, b"DOLLYDOG", b"Dolly Dog Coin", b"From the charming streets of our city to the digital world, #DOLLY has inspired her very own cryptocurrency  $DOLLYDOG Coin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/m_VUB_Na_Q_400x400_dfd66bf118.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLLYDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLLYDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

