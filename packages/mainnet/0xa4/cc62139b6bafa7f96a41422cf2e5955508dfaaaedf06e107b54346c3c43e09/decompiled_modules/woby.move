module 0xa4cc62139b6bafa7f96a41422cf2e5955508dfaaaedf06e107b54346c3c43e09::woby {
    struct WOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOBY>(arg0, 6, b"WOBY", b"SUI WOBY", x"574f42592069736e74206a75737420616e7920636861726163746572206f7574206f66206120626f6f6b2e2048657320776179206d6f7265207468616e20746861742e0a486527732074686520756c74696d6174652069636f6e2065766572796f6e6520647265616d73206f66206265636f6d696e6720616e6420746865206e657874206d6173636f74206f662053554921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WOBY_065497bc4a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

