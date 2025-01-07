module 0xe8d7d0ecf1cb2b6478f22ede66a2ce2d14b5967d574bbf0988c168fe7230af07::auva {
    struct AUVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUVA>(arg0, 6, b"AUVA", b"Auva", x"5361792068656c6c6f20746f20415556412c206f757220667269656e646c7920414920636f6d70616e696f6e206275696c74206f6e2074686520536f6c616e612065636f73797374656d20746f206272696e6720746f676574686572207468652062657374206f6620646563656e7472616c697a65642066696e616e636520616e64204d656d652d496e7370697265642043756c747572652e0a574849544550415045523a68747470733a2f2f6769746875622e636f6d2f41757661446576", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e5_NHDR_5o_400x400_7813452e01.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AUVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

