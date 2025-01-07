module 0xb1c1c834f933c05804804d4e003a1b416e1d6ebebf7945bd16095c9e8cf02ed::nbtc {
    struct NBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NBTC>(arg0, 6, b"nBTC", b"First Nigga to buy Bitcoin", b"First nBTC on Sui run it!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0588_ee5255e0b3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

