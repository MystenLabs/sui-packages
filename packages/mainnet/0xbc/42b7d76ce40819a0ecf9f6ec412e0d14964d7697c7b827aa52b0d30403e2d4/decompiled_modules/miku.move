module 0xbc42b7d76ce40819a0ecf9f6ec412e0d14964d7697c7b827aa52b0d30403e2d4::miku {
    struct MIKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKU>(arg0, 6, b"MIKU", b"Miku Sui", b"The Waifu Revolution on the Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigj4ae4fb5erx3kwd7l5wxu77524dxmth46xjctt5ilt5lwu7tyy4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MIKU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

