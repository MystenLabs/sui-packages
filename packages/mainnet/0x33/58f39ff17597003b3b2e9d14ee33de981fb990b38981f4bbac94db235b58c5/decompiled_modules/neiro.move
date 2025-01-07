module 0x3358f39ff17597003b3b2e9d14ee33de981fb990b38981f4bbac94db235b58c5::neiro {
    struct NEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRO>(arg0, 6, b"NEIRO", b"Neiro on sui", b"$NEIRO is a new cryptocurrency with a total supply of 1 billion tokens, offering zero buy/sell tax and no team tokens, which suggests a community-driven approach. It promotes itself as the next big opportunity in the crypto space, drawing comparisons to Dogecoin's rise.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000092992_d6d0b8ff5f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

