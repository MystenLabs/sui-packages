module 0xd05eb3e09ca0d3f8ea7fc5fadac1a6e45bbac5557d873051df9266c885fe960b::usd1 {
    struct USD1 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<USD1>, arg1: 0x2::coin::Coin<USD1>) {
        0x2::coin::burn<USD1>(arg0, arg1);
    }

    fun init(arg0: USD1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USD1>(arg0, 9, b"TRX", b"TRX", b"Trx. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicuohgyte2wue6ncu7qtm5ollj3tl24cipehglglao4dp6aginzum")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<USD1>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USD1>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<USD1>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<USD1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

