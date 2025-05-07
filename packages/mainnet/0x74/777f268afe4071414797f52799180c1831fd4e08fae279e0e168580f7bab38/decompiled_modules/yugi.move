module 0x74777f268afe4071414797f52799180c1831fd4e08fae279e0e168580f7bab38::yugi {
    struct YUGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUGI>(arg0, 6, b"YUGI", b"Yu-Gi-Oh sui", x"59752d47692d4f6820636f6d696e67206f6e207375692074686973206d6f6e74680a68747470733a2f2f782e636f6d2f456d616e4162696f2f7374617475732f31393230313436373839333637323134333632", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigmp4phfg6zzt27ye5tnjacuqzwfvbx3klomeynlwlbqd3vell4fy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YUGI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

