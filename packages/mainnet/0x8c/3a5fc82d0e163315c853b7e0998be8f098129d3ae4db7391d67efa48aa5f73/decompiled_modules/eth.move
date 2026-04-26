module 0x8c3a5fc82d0e163315c853b7e0998be8f098129d3ae4db7391d67efa48aa5f73::eth {
    struct ETH has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ETH>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ETH>>(0x2::coin::mint<ETH>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: ETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETH>(arg0, 9, b"ETH", b"Ethereum", b"Personal Ethereum token on Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/lgm1831/sui/main/Ethereum.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

