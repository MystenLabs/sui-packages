module 0x84f50003b6679a91d5bfd0462db196be30160e3a99b47649dc2dbf7014d16fd1::b_ivy {
    struct B_IVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_IVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_IVY>(arg0, 9, b"bIVY", b"bToken IVY", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_IVY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_IVY>>(v1);
    }

    // decompiled from Move bytecode v6
}

