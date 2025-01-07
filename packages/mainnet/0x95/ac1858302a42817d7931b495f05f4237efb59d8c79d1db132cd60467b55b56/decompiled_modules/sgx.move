module 0x95ac1858302a42817d7931b495f05f4237efb59d8c79d1db132cd60467b55b56::sgx {
    struct SGX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGX>(arg0, 6, b"SGX", b"Sui grincat xmas", b"A Cat who stole Christmas ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053193_6ba256aa40.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGX>>(v1);
    }

    // decompiled from Move bytecode v6
}

