module 0xd8fd32940ab4e51c7788624884375da9123dc9377810d2c9f88b6d7fd527d502::chill {
    struct CHILL has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHILL>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CHILL>>(0x2::coin::mint<CHILL>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: CHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILL>(arg0, 9, b"ChillThug", b"CHILLTHUG", b"Just a Chill Thug", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump.mypinata.cloud/ipfs/QmfDTYFYkZvwXLYDVqTUdiwE7e8HGqQyNqUFffY9YYu7eG?img-width=256&img-dpr=2&img-onerror=redirect")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHILL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILL>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

