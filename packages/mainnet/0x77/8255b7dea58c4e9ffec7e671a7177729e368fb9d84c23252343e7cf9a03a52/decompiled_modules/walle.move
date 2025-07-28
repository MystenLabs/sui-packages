module 0x778255b7dea58c4e9ffec7e671a7177729e368fb9d84c23252343e7cf9a03a52::walle {
    struct WALLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALLE>(arg0, 6, b"Walle", b"Walle The Owl", x"496e706972656420627920746865206d6f737420706f70756c6172207765636861740a737469636b65722057616c6c6520746865204f776c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicevdxcmmq6nkp7aujhkg6zlix4sl7u6usrgbvwhy3xjpl766toca")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WALLE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

