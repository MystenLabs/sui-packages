module 0x98772d41b5ca4853cb9cdd116dce6467821010727a73310417448f5cba5b4a95::bcat {
    struct BCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCAT>(arg0, 6, b"BCAT", b"BLUE CAT  ON SUI", b"Blue Cat on SUI is a fun and energetic meme token launched on the SUI blockchain, inspired by the iconic blue cartoon cat that represents happiness, community, and chaos in the best way. $BCAT brings a playful spirit to Web3 while riding the wave of liquidity and innovation powered by Move Pump. Join the movement, embrace the meme, and let's make SUI meow!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bluecat_9480cdf3b5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

