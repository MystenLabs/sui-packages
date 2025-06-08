module 0x94bcd582091e94d3b7a65119b8ef107ac81edc34d704d2641ee58270ab8b9883::yas {
    struct YAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAS>(arg0, 6, b"YAS", b"YOU A SHIT", b"YOU A SHIT YAS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiakgb4aktnul7diq2pw2bfuujsewqfwakreag7sxj6crzeqgnzuny")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

