module 0xf8166f2ee333c7b500612f0652e8b5dbbde42230d019a4cdc944473629c057ae::magnesui {
    struct MAGNESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGNESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGNESUI>(arg0, 6, b"MAGNESUI", b"Magnesui Pokemon", b"Magnesui is a magnet pokemon, attracting all the money flow on the sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicbg6upmx2nlasw3bsgmqxbgh6rhqcsukmslfjjugsogkzthwzo6a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGNESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAGNESUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

