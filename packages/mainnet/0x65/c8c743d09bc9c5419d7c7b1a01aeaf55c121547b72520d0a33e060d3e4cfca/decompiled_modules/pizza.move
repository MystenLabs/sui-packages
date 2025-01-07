module 0x65c8c743d09bc9c5419d7c7b1a01aeaf55c121547b72520d0a33e060d3e4cfca::pizza {
    struct PIZZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIZZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIZZA>(arg0, 6, b"PIZZA", b"First Pizza On Sui", b"Slice up your gains with First $PIZZA On Sui  the token thatll make your wallet as full as your stomach!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/pfp_0d096c06e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIZZA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIZZA>>(v1);
    }

    // decompiled from Move bytecode v6
}

