module 0x4630a06abea86784edfaf02f9f9164c74150034c0572249784b31d732b5627::suba {
    struct SUBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUBA>(arg0, 6, b"SUBA", b"Yotsuba Koiwai", x"596f7473756261204b6f697761692069732074686520677265656e2d686169726564206769726c2077686f206372656174656420535549434841494e206964656e746974792e200a546865206f726967696e616c206d6173636f74206f6620696e7465726e657420616e61726368792072657475726e732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib6yh2cwu7caqzqbxtkktcpiys4iartpawxrroz4kpjb3ljnwe6pe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUBA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

