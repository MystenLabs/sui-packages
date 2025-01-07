module 0xee3abca23ba9d0e482a14c6061731aa1fa645d98a3352f480115ccfa7be8beca::bluebanana {
    struct BLUEBANANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEBANANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEBANANA>(arg0, 6, b"BLUEBANANA", b"Blue Banana", b"This is rare blue banana, hodl and you will become bananillionaire, ignore and you will fail forever.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0296_f7af199ab2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEBANANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEBANANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

