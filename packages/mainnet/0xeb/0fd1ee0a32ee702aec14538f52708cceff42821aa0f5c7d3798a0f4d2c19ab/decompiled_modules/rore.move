module 0xeb0fd1ee0a32ee702aec14538f52708cceff42821aa0f5c7d3798a0f4d2c19ab::rore {
    struct RORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RORE>(arg0, 6, b"RORE", b"Rore the cat", b"Crocheted a beanie for my friends cat with tiny beans. $RORE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000056524_55498dc94c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RORE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RORE>>(v1);
    }

    // decompiled from Move bytecode v6
}

