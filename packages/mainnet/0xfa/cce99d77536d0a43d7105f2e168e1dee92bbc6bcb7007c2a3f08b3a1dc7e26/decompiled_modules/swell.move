module 0xfacce99d77536d0a43d7105f2e168e1dee92bbc6bcb7007c2a3f08b3a1dc7e26::swell {
    struct SWELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWELL>(arg0, 6, b"SWELL", b"SWELL SOON ON SUI", x"5374616b6520776974682073774554482c207273774554482c20616e6420737742544320616e64206a6f696e205377656c6c204c322e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/swell_54ecc78821.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWELL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWELL>>(v1);
    }

    // decompiled from Move bytecode v6
}

