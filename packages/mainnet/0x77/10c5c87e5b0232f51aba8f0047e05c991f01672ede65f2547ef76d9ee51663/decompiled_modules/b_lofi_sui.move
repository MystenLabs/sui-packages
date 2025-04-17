module 0x7710c5c87e5b0232f51aba8f0047e05c991f01672ede65f2547ef76d9ee51663::b_lofi_sui {
    struct B_LOFI_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_LOFI_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_LOFI_SUI>(arg0, 9, b"blofiSUI", b"bToken lofiSUI", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_LOFI_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_LOFI_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

