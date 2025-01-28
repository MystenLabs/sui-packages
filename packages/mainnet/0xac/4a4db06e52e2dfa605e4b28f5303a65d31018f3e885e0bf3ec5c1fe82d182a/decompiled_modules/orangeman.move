module 0xac4a4db06e52e2dfa605e4b28f5303a65d31018f3e885e0bf3ec5c1fe82d182a::orangeman {
    struct ORANGEMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORANGEMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORANGEMAN>(arg0, 6, b"OrangeMan", b"Orange Man", x"4865792c204920646f6e74206c6f6f6b206c696b65205472756d70210a496d206a75737420616e206f72616e67652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2025_01_28_153451056_acc61727b5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORANGEMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORANGEMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

