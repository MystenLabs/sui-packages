module 0xbe7a9bd2fc02017c467ba74ed84ab766f78a7aef32e53f5192c476a0e5cc6df6::pnutardio {
    struct PNUTARDIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUTARDIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUTARDIO>(arg0, 6, b"PNUTARDIO", b"Peanutardio", x"24504e5554415244494f20686173206265636f6d6520746865206e6577206661766f72697465207472656e642069742773207468652070656f706c6527732073706972697420666f72205472756d7020746f2077696e2074686520656c656374696f6e20323032342e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0173_083d3b038c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUTARDIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNUTARDIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

