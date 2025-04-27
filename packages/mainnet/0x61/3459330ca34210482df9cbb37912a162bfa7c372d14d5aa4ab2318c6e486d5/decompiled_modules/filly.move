module 0x613459330ca34210482df9cbb37912a162bfa7c372d14d5aa4ab2318c6e486d5::filly {
    struct FILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FILLY>(arg0, 6, b"FILLY", b"Sui Filly", x"57686f207361696420747572746c65732061726520736c6f773f0a4d656574202446494c4c592c20746865206661737465737420747572746c65206f6e2074686520416273747261637420436861696e210a426c696e6b20616e642068657320616c7265616479203130782061686561642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000062988_08d2ab5148.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

