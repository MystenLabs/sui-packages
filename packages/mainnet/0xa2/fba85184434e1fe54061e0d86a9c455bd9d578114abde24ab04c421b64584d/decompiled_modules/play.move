module 0xa2fba85184434e1fe54061e0d86a9c455bd9d578114abde24ab04c421b64584d::play {
    struct PLAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLAY>(arg0, 6, b"PLAY", b"PLAYTRON", x"546865204f7065726174696e672053797374656d20666f722047616d65732e0a47616d696e672c2074656368202620656e7465727461696e6d656e7420636f6d6d656e746172792c206e6577732c207061726f6479202620616e616c797369732e0a0a746865206f6666696369616c20746f6b656e206f6620737569706c617930783120616e642061697264726f7020666f7220737569706c617920686f6c6465727320616e6420686f6c64696e67203125206f662024706c61792077696c6c2072656365697665642061697264726f70", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigasd7ypfu2rh3mi7jzhen24fanvypovrybi7gd4nwgzcw573d3oi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PLAY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

