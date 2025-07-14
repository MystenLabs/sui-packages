module 0xf60e3a2a399d137db0fafb89a7e7766e5d478039dac17f985759390f497a5d83::b_a80085 {
    struct B_A80085 has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_A80085, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_A80085>(arg0, 9, b"bA80085", b"bToken A80085", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_A80085>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_A80085>>(v1);
    }

    // decompiled from Move bytecode v6
}

