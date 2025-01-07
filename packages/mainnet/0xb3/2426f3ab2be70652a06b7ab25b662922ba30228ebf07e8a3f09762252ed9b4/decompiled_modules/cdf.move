module 0xb32426f3ab2be70652a06b7ab25b662922ba30228ebf07e8a3f09762252ed9b4::cdf {
    struct CDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CDF>(arg0, 6, b"CDF", b"Cat Dog Fish", b"The Cat Dog Fish of the SUI Ocean, ready to make it 1B meme coin!!! Secure your position!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/877f8131_a6dc_4ef3_9d0a_9d88f1aed90c_ab6b392787.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

