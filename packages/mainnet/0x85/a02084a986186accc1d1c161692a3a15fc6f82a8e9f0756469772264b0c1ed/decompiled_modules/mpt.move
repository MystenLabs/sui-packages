module 0x85a02084a986186accc1d1c161692a3a15fc6f82a8e9f0756469772264b0c1ed::mpt {
    struct MPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MPT>(arg0, 8, b"TRUMP", b"trump", b"This is a trump token description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://amber-hilarious-ostrich-689.mypinata.cloud/files/bafkreidxafmelx4leds5kgqwwxvkapageyq4tf7f74k2nw4nkz4wbgwzqy?X-Algorithm=PINATA1&X-Date=1732115277&X-Expires=315360000&X-Method=GET&X-Signature=3f1efa47861cfe6523a38f5d0a88b4856219175cb2bee633f0909e0c952cd399"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MPT>(&mut v2, 1000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MPT>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MPT>>(v2);
    }

    // decompiled from Move bytecode v6
}

