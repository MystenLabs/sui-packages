module 0x4dc5dba3a7cf3e5375c7e26b48ed97eded9ad36a8b6b6cc5f6c2a544521a8a91::b_coon {
    struct B_COON has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_COON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_COON>(arg0, 9, b"bCOON", b"bToken COON", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_COON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_COON>>(v1);
    }

    // decompiled from Move bytecode v6
}

