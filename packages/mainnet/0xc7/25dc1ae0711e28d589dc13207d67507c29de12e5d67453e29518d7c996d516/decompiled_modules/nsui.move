module 0xc725dc1ae0711e28d589dc13207d67507c29de12e5d67453e29518d7c996d516::nsui {
    struct NSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSUI>(arg0, 6, b"NSUI", b"NEIRO on SUI", x"244e4549524f207468652048656972204170706172656e7420746f20646f6467652e20746865204e657720536869626120494e5520436f6d696e6720746f20245355490a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u0rx_Azc1_400x400_118d572bc2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

