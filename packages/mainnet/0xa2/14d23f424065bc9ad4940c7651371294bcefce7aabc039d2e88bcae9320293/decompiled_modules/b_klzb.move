module 0xa214d23f424065bc9ad4940c7651371294bcefce7aabc039d2e88bcae9320293::b_klzb {
    struct B_KLZB has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_KLZB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_KLZB>(arg0, 9, b"bKLZB", b"bToken KLZB", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_KLZB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_KLZB>>(v1);
    }

    // decompiled from Move bytecode v6
}

