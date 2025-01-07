module 0xcacabfff88391f2201a5ad0b25e33fac8a3e1602e152bcdf8483c2a5d701d21d::ching {
    struct CHING has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHING>(arg0, 9, b"Ching", b"Evon Ching", b"Evan Chengs retarded twin $CHING chiching on $SUI Join jeetzz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1838953167805161472/4e8P8kFU_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHING>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHING>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHING>>(v1);
    }

    // decompiled from Move bytecode v6
}

