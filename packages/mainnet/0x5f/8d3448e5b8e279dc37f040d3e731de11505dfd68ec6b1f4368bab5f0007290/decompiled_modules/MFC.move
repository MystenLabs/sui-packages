module 0x5f8d3448e5b8e279dc37f040d3e731de11505dfd68ec6b1f4368bab5f0007290::MFC {
    struct MFC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MFC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MFC>(arg0, 6, b"Meme Fighting Championship", b"MFC", x"54686520756c74696d61746520626174746c6520726f79616c65206f66206d656d6520636f696e7321204d4643206272696e677320746f67657468657220746865206d6f737420766972616c20616e64206f7574726167656f7573206d656d6520636f696e7320696e2061206e6f2d686f6c64732d62617272656420666967687420666f7220646f6d696e616e63652e204f6e6c7920746865207374726f6e67657374206d656d65732073757276697665e280946a6f696e20746865206172656e6120616e64206c657420746865206d656d657320626174746c65206974206f757421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"blob:https://mfc.club/de33ab08-f506-4164-be4f-4a54ef639f4f")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MFC>>(v0, @0x691c5d4f7bd7c39b39907d3ca01b8c2643c87de134766ca4f78be51e0a9fde1b);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MFC>>(v1);
    }

    // decompiled from Move bytecode v6
}

