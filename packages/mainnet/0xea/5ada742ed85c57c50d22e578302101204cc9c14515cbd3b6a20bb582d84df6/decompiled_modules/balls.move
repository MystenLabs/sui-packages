module 0xea5ada742ed85c57c50d22e578302101204cc9c14515cbd3b6a20bb582d84df6::balls {
    struct BALLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALLS>(arg0, 6, b"BALLS", b"TESTICLES OF SUI", b"The bold new token on Sui thats all about strength and resilience! Representing the power of every holder, $BALLS stands for courage, unity, and an unbreakable spirit. With a community as solid as its name, $BALLS is ready to make an impact on the Sui network. Get ready to hold with confidence and show your strength!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ballsss_e4fb8fd653.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

