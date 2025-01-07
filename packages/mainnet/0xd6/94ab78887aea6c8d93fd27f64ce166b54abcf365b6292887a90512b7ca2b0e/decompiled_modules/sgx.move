module 0xd694ab78887aea6c8d93fd27f64ce166b54abcf365b6292887a90512b7ca2b0e::sgx {
    struct SGX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGX>(arg0, 6, b"SGX", b"Sui grincat xmas", x"41204361742077686f2073746f6c65204368726973746d61730a4d65727279204368726973746d617320746f20616c6c20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053193_679c490d23.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGX>>(v1);
    }

    // decompiled from Move bytecode v6
}

