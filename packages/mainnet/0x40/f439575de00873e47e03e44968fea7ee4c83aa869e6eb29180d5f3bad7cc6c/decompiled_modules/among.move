module 0x40f439575de00873e47e03e44968fea7ee4c83aa869e6eb29180d5f3bad7cc6c::among {
    struct AMONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AMONG>(arg0, 6, b"Among", b"Among Sui", b"Dev is immposter", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeic7nvsfrfkfjxo3exndfwx2vyeqydjkpikbvkkcfkp2qs7jf4tnnm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AMONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AMONG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

