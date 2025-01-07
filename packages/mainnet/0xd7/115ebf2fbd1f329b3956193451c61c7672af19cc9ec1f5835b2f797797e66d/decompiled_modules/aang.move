module 0xd7115ebf2fbd1f329b3956193451c61c7672af19cc9ec1f5835b2f797797e66d::aang {
    struct AANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AANG>(arg0, 6, b"AANG", b"AAANG SUI", b"Aang Sui:  Bend the market with the power of the Avatar! Join the Sui Chains most promising memecoin. Lets ride this wave together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_2_66b9f91217.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

