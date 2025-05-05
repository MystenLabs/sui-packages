module 0x1c72c34d6dc9e7805b10856ade7831ffa22e506919009f1614fe962e7899532c::b_wes {
    struct B_WES has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_WES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_WES>(arg0, 9, b"bWES", b"bToken WES", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_WES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_WES>>(v1);
    }

    // decompiled from Move bytecode v6
}

