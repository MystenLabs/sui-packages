module 0xa110934baf26df24a8be4c9e3aef9501d19047660b828936d2a9061610d0307d::caffeine {
    struct CAFFEINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAFFEINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAFFEINE>(arg0, 6, b"CAFFEINE", b"TRENCH FUEL", b"THE TRENCHES NEED TO REFUEL!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicl5w2sqtqo76dmt4tx4xhitjdyj5vhzmpqrxhd5u4hq7qvczjteu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAFFEINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAFFEINE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

