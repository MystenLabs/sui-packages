module 0x9753a815080c9a1a1727b4be9abb509014197e78ae09e33c146c786fac3731e0::bpoint {
    struct BPOINT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BPOINT>, arg1: 0x2::coin::Coin<BPOINT>) {
        0x2::coin::burn<BPOINT>(arg0, arg1);
    }

    fun init(arg0: BPOINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPOINT>(arg0, 9, b"BP", b"Bluefin Points", b"Bluefin points earned by interacting with the Bluefin Protocol", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BPOINT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPOINT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BPOINT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<BPOINT>(arg0) + arg1 <= 1000000000000000000, 1);
        0x2::coin::mint_and_transfer<BPOINT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

