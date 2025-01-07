module 0x790bf5089ac7a7856e6dbc460b47c95142abf5cc7c5c7f2f31bdf3bd23cf379e::pingu {
    struct PINGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINGU>(arg0, 6, b"PINGU", b"PINGU SUI", b"PINGU ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/XY_81_H_Ih4_400x400_e6d066b3c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

