module 0xc9e305ae0e8ab8b568f534b9a3e950a4289b87b73fef67428d7ad8b394c30175::b_rod {
    struct B_ROD has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_ROD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_ROD>(arg0, 9, b"bROD", b"bToken ROD", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_ROD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_ROD>>(v1);
    }

    // decompiled from Move bytecode v6
}

