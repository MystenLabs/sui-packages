module 0x45374cd0c4782224854303a307d9e451571156cc0b53e0c96bb5efe2c8bedf4e::fg {
    struct FG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FG>(arg0, 6, b"FG", b"FEAR & GREED", b"Fear and Greed is a next gen crypto analytics platform and decentralized exchange that dives deeper into market sentiment. Beyond basic price action, it analyzes emotional dynamics fear, greed, and everything in between, using real time data, sentiment signals, and smart indicators to empower traders with sharper, psychology driven insights.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiggansx2trgdxn2oaib5f7zbijrfn6zd7ugv6nbpxdtuoqdnxr3b4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

