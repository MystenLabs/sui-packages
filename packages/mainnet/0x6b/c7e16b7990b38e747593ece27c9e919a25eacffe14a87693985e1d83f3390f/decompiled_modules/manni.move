module 0x6bc7e16b7990b38e747593ece27c9e919a25eacffe14a87693985e1d83f3390f::manni {
    struct MANNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANNI>(arg0, 6, b"MANNI", b"Manni The Mammoth", b"I'm Manni. Make Mammoths Great Again #MMGA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidpoxqphsu7j55piyxcz7yukpwqvsri7rmdickfb5uuwv3xywdw6e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANNI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MANNI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

