module 0x6fe6f3e26df5505c86949b5b24548cfb27a0cf47244df7ecac8ec1738e64af1::pts {
    struct PTS has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<PTS>, arg1: 0x2::coin::Coin<PTS>) {
        0x2::coin::burn<PTS>(arg0, arg1);
    }

    fun init(arg0: PTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTS>(arg0, 7, b"PTS", b"KLARNA POINTS", b"CONGRATULATIONS! HERE IS A VERY SPECIAL THANK YOU GIFT FOR WORKING WITH KLARNA AND PAYING OFF YOUR DEBT IN FULL! THESE POINTS CAN BE USED TO PURCHASE GIFT CARDS AND MORE FROM KLARNA. WE SERVE THE GENERAL PUBLIC AND ARE NOT LIABLE FOR LOST FUNDS OR LACK OF SERVICE DUE TO COMPUTER GLITCHES. WE/I /US/ANY OF OUR PAID WORKERS OR SUB CONTRACTORS / ARE NOT LIABLE FOR LOST DATA OR UNAVAILABLE ANALYTICS FROM CARDS OR TRANSACTIONS HISTORY. COPYRIGHTS AND TRADEMARKS ARE ALL PROPERTY OF THEIR RESPECTIVE OWNERS. 2026-2096", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeievyscnn3a3po4isvgcohbv5t6b4jdcsyycidmbzu3nirtbqjbwcy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTS>>(v1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PTS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PTS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

