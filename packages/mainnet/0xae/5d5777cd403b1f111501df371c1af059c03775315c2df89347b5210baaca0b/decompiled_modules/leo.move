module 0xae5d5777cd403b1f111501df371c1af059c03775315c2df89347b5210baaca0b::leo {
    struct LEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEO>(arg0, 6, b"LEO", b"Sui Paus Leo X1V", b"may god bless you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000068299_cfad8767be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

