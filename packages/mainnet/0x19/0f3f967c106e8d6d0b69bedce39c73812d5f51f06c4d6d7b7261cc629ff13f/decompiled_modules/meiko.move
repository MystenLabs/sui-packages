module 0x190f3f967c106e8d6d0b69bedce39c73812d5f51f06c4d6d7b7261cc629ff13f::meiko {
    struct MEIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEIKO>(arg0, 6, b"MEIKO", b"MOONEIKO SHIRAKI", x"4d45494b4f20697320796f7572207469636b657420746f20612066756e20616e6420726577617264696e67206a6f75726e6579206f6e205375690a4d45494b4f20746f6b656e73206f6e204d6f6f6e42616773204c61756e6368706164206265666f72652074686579726520676f6e65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih5vplskzmkpmfsbkhyhnyw5f524lqycnqe6aor7nf3dl7d4b5334")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEIKO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

