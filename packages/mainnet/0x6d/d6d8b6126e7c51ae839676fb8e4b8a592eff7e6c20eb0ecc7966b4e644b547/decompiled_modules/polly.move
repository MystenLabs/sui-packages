module 0x6dd6d8b6126e7c51ae839676fb8e4b8a592eff7e6c20eb0ecc7966b4e644b547::polly {
    struct POLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLLY>(arg0, 6, b"POLLY", b"Polly The Polar Bear", b"Polly has made her way from the seas to the SUI seas!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/coinerpfp_a23e196156.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

