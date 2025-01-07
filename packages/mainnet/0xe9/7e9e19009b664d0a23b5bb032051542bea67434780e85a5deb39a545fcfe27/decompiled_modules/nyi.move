module 0xe97e9e19009b664d0a23b5bb032051542bea67434780e85a5deb39a545fcfe27::nyi {
    struct NYI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYI>(arg0, 6, b"NYI", b"NYI RORO KIDUL", b"I am the Queen of the South Sui Sea.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000084647_7dc69a7045.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NYI>>(v1);
    }

    // decompiled from Move bytecode v6
}

