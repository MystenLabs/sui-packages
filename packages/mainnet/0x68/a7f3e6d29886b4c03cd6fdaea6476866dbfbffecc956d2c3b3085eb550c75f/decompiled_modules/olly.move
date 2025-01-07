module 0x68a7f3e6d29886b4c03cd6fdaea6476866dbfbffecc956d2c3b3085eb550c75f::olly {
    struct OLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLLY>(arg0, 6, b"OLLY", b"OLLY Sui", b"Olly is the cutest cat on the internet .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000152314_1db421bbe5.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OLLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

