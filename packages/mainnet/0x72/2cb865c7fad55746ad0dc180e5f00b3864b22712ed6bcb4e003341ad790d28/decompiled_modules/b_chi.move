module 0x722cb865c7fad55746ad0dc180e5f00b3864b22712ed6bcb4e003341ad790d28::b_chi {
    struct B_CHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_CHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_CHI>(arg0, 9, b"bCHI", b"bToken CHI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_CHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_CHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

