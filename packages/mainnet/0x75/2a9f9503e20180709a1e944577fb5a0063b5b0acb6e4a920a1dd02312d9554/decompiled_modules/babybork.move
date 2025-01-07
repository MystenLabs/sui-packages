module 0x752a9f9503e20180709a1e944577fb5a0063b5b0acb6e4a920a1dd02312d9554::babybork {
    struct BABYBORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYBORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYBORK>(arg0, 6, b"BABYBORK", b"Baby Bork", x"496e74726f647563696e67204261627920426f726b20546865204e6577204261627920497320496e20546f776e0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/black_box_826de6d1a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYBORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYBORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

