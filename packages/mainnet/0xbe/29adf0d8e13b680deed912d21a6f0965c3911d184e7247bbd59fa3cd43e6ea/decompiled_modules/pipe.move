module 0xbe29adf0d8e13b680deed912d21a6f0965c3911d184e7247bbd59fa3cd43e6ea::pipe {
    struct PIPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPE>(arg0, 6, b"PIPE", b"Pink Pepe on Sui", b"First Pink Pepe on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_1x1_3_768x768_ac20a5dac2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

