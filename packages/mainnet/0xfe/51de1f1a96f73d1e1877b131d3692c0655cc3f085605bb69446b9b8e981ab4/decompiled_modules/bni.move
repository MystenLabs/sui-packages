module 0xfe51de1f1a96f73d1e1877b131d3692c0655cc3f085605bb69446b9b8e981ab4::bni {
    struct BNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNI>(arg0, 6, b"BNI", b"Bee Network", x"4e6576657220746f6f206c61746520746f206a6f696e20426565204e6574776f726b202d2074686973206772656174206a6f75726e657920746f67657468657220776974682034312c3330382c373632204265656c6965766572732061726f756e642074686520776f726c6420f09f909d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/beeaacc2-ff7d-4c5a-9c2b-732d1bc6cc7e.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

