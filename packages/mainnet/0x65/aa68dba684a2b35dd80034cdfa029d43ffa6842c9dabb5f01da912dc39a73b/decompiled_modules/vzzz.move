module 0x65aa68dba684a2b35dd80034cdfa029d43ffa6842c9dabb5f01da912dc39a73b::vzzz {
    struct VZZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: VZZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VZZZ>(arg0, 0x9e20798d97c110f6b36b7b3d8543aa9246322ef2fd8d83ad79ef3325d473bc2f::constants::lp_decimals(), b"VZZZ", b"Vibe", b"Pure Vibezzz!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance/coins/perpetuals/default.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VZZZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VZZZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

