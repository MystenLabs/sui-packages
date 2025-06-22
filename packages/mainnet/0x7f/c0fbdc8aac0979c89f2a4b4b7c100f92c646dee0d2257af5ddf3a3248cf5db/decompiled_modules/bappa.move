module 0x7fc0fbdc8aac0979c89f2a4b4b7c100f92c646dee0d2257af5ddf3a3248cf5db::bappa {
    struct BAPPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAPPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAPPA>(arg0, 6, b"BAPPA", b"Sui Bappa", x"4d65657420424150504120696e73706972656420627920746865206d7974686963616c0a4a6170616e657365206b617070612c20737569206272696e677320796f752042617070612e0a46756c6c206f6620696e74726967756520616e64206d7973746572792e2057686572652077696c6c0a686973206a6f75726e65792074616b652068696d20616e6420776861742077696c6c2069740a656e7461696c2077652077696c6c207365652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidvvl5li5mm3iftelunfatci2hfn7mcpjziaqx43mzvitrhqmhetq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAPPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BAPPA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

