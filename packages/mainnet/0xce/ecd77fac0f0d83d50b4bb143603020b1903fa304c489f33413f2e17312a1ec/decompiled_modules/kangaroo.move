module 0xceecd77fac0f0d83d50b4bb143603020b1903fa304c489f33413f2e17312a1ec::kangaroo {
    struct KANGAROO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KANGAROO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KANGAROO>(arg0, 6, b"KANGAROO", b"KANGAROO BEACH", x"5f4b616e6761726f6f5f42656163685f0a466f757220796f756e6720616e696d616c20667269656e647320736861726520616e20616374696f6e2d7061636b65642073756d6d657220747261696e696e67206173206361646574732077697468207468656972206c6966656775617264206865726f65732c206b656570696e67207468652077617465722073616665206174207468652073706563746163756c6172204b616e6761726f6f2042656163682e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3769_56b753d0d7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KANGAROO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KANGAROO>>(v1);
    }

    // decompiled from Move bytecode v6
}

