module 0x3384a084fce486480488c9b1dba7e677f47a098b7d9a414b7c7a43822515bc36::blork {
    struct BLORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLORK>(arg0, 6, b"Blork", b"mOOnBlOrk", x"f09f8c8a20517569726b79206d69736669747320726973696e672066726f6d20746865206465707468732e204d7973746572792c206d697363686965662c20616e6420612073706c617368206f662063757465206368616f732e200af09f9fa020426c6f726b20646f696e6720426c6f726b207468696e67732e200a24737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiflh5dbhyyhhxcilavocdrga2l4ox2n22rjdovabxagnnl3cfopvu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLORK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

