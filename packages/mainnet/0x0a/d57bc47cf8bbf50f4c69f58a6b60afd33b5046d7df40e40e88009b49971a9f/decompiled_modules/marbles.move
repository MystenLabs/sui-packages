module 0xad57bc47cf8bbf50f4c69f58a6b60afd33b5046d7df40e40e88009b49971a9f::marbles {
    struct MARBLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARBLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARBLES>(arg0, 6, b"MARBLES", b"MARBLE SAGA", x"506c617920796f7572204d6172626c652026204561726e200a4d6172626c652053616761206973206120726163696e67207468656d65642067616d652e20506c617965727320617265206f6e6c792061736b656420746f20636f6d706574652077697468206f7468657220706c61796572732c20636f6d6d756e69636174652c20616e64206265636f6d652077696e6e65727320616e642067657420746f6b656e206173207265776172647320244d4152424c45532e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/marblesui_61b3854c87.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARBLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARBLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

