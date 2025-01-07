module 0x85ad970a0a0d07f74351160b110782ca2c2803c23d3774320e3c255771eb5e6a::ngn {
    struct NGN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGN>(arg0, 6, b"NGN", b"THE LEGEND OF THE NINGEN", b"I come from the unknown depths of water ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031459_718b58e661.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NGN>>(v1);
    }

    // decompiled from Move bytecode v6
}

