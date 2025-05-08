module 0xf1a5e8ead3c7d9ab8942fb7cfc28df141c6db32663c256a11657a396f87b4a9f::b_poop_sui {
    struct B_POOP_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_POOP_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_POOP_SUI>(arg0, 9, b"bpoopSUI", b"bToken poopSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_POOP_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_POOP_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

