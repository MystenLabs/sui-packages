module 0x4ffbec4cc8b1a2265d2355e824d5493e62b86cfb9d6ecfd6e9fafcd1afa110f::rabitlolll {
    struct RABITLOLLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RABITLOLLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RABITLOLLL>(arg0, 6, b"RABITLOLLL", b"RABBITLOLLL", x"726162697420287261626974290a466f6c6c6f7720746865202472616269742c20616e6420746865206a6f75726e657920626567696e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_4_4baa0fbac9.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RABITLOLLL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RABITLOLLL>>(v1);
    }

    // decompiled from Move bytecode v6
}

