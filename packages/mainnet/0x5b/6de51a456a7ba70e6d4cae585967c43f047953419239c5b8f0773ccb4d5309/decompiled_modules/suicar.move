module 0x5b6de51a456a7ba70e6d4cae585967c43f047953419239c5b8f0773ccb4d5309::suicar {
    struct SUICAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAR>(arg0, 6, b"SUICAR", b"Sui Car", b"Introducing Sui Car. Powered by water, this sleek machine cruises the Sui Network with eco-friendly speed. Its fast, efficient, and leaving other tokens in the dust. Hop in, and lets ride the waves with Sui Car!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/PP_a662abfe54.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

