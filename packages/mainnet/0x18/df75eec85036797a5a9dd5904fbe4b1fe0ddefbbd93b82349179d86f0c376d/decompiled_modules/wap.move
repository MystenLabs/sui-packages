module 0x18df75eec85036797a5a9dd5904fbe4b1fe0ddefbbd93b82349179d86f0c376d::wap {
    struct WAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAP>(arg0, 9, b"WAP", b"Wet Ass Pussy", b"The Wettest Ass Pussy on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/Bz7vVzQhm2KMW1XgcrDruYega1MiwrAs1DQysrx4tFkp.png?size=xl&key=69453f")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WAP>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

