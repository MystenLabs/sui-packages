module 0xacdec1d9f9897e6d9bf868d224988c695bc1e1b89eb35ce3fdffb6faa66d50b6::suirat {
    struct SUIRAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRAT>(arg0, 6, b"SUIRAT", b"Sui Rat", b"Sneaky and resourceful, $SUIRAT scurries through the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_1_7a982c6624.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

