module 0x1f685597efbd8f2902ee762398fd5fdcc75bd8fd8f403c85db0d931b1d9e432f::wailord {
    struct WAILORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAILORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAILORD>(arg0, 6, b"WaiLORD", b"WAILORD POKEMON", x"5761696c6f7264206973206f6e65206f6620746865206c61726765737420506f6bc3a96d6f6e20746f2068617665206265656e20646973636f76657265642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeieiorpshoc5zoquaqybnhjlqf45ljf2gpq2qnajdblp35m55w7cey")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAILORD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAILORD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

