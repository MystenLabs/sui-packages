module 0x4ff9a35356293b480011f5af164ef3fda3bab5c974aa53cf38e22f9fc53ca160::b_blast {
    struct B_BLAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_BLAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_BLAST>(arg0, 9, b"bBlast", b"bToken Blast", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_BLAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_BLAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

