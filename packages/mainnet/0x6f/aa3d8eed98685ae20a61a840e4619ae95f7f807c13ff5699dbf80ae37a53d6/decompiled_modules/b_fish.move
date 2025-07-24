module 0x6faa3d8eed98685ae20a61a840e4619ae95f7f807c13ff5699dbf80ae37a53d6::b_fish {
    struct B_FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_FISH>(arg0, 9, b"bFISH", b"bToken FISH", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_FISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_FISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

