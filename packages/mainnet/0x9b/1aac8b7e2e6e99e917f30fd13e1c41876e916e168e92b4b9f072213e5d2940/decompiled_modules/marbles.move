module 0x9b1aac8b7e2e6e99e917f30fd13e1c41876e916e168e92b4b9f072213e5d2940::marbles {
    struct MARBLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARBLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARBLES>(arg0, 6, b"MARBLES", b"Marble Saga", x"506c617920796f7572204d6172626c6526204561726e0a4d6172626c6520536167612047616d65206973206120726163696e67207468656d65642067616d652e20506c617965727320617265206f6e6c792061736b656420746f20636f6d706574652077697468206f7468657220706c61796572732c20636f6d6d756e69636174652c20616e64206265636f6d652077696e6e65727320616e642067657420746f6b656e2061732072657761726473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/marblesui_fcaa386e8f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARBLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARBLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

