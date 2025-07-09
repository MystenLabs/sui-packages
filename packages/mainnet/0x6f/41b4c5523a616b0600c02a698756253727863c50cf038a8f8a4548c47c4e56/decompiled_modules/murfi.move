module 0x6f41b4c5523a616b0600c02a698756253727863c50cf038a8f8a4548c47c4e56::murfi {
    struct MURFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MURFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MURFI>(arg0, 6, b"MURFI", b"Sui Murfi", b"I am MURFI the ocean god on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000087074_45868dd597.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MURFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MURFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

