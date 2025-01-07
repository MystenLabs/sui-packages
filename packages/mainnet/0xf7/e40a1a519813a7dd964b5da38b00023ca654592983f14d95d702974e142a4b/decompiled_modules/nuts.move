module 0xf7e40a1a519813a7dd964b5da38b00023ca654592983f14d95d702974e142a4b::nuts {
    struct NUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUTS>(arg0, 6, b"NUTS", b"TESTICLES OF HOLDERS", b"The bold new token on Sui thats all about strength and resilience! Representing the power of every holder, $NUTS stands for courage, unity, and an unbreakable spirit. With a community as solid as its name, $NUTS is ready to make an impact on Sui! So, are you ready to hold?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ballsss_f947020afd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

