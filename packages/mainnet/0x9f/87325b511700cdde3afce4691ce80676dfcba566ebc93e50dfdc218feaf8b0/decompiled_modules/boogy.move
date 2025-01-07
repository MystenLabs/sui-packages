module 0x9f87325b511700cdde3afce4691ce80676dfcba566ebc93e50dfdc218feaf8b0::boogy {
    struct BOOGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOGY>(arg0, 9, b"BOOGY", b"Boogie", b"BoogieToken (BOOGY) is a high-energy, fun token made for those who love to shake things up in crypto. With fast transactions, low fees, and a vibrant community, BOOGY lets you trade and stake to the rhythm of innovation. Step into the groove of DeFi with BoogieToken!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1840345343864500224/5GPfqna6.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOOGY>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOGY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOGY>>(v1);
    }

    // decompiled from Move bytecode v6
}

