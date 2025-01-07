module 0x20e92c5dcfbf12258087b1be240d532ebc88dda1537361fecc5bcd4d72fbe3ba::bogus {
    struct BOGUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOGUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOGUS>(arg0, 9, b"BOGUS", b"Bogus", b"Celebrating the absurdity of web3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0xed1497e973f43037d63479622b614dbe6741ca9b.png?size=xl&key=85b832")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOGUS>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOGUS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOGUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

