module 0x4ab6b9c8b30003eb92a6baab056d64308dbf1a0ce03f94ad8ca35c6ec11b8495::pushy {
    struct PUSHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUSHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUSHY>(arg0, 6, b"Pushy", b"Pushy", b"Pushy pair launch on SUi Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHYoHoePlshl-Hj31jO1Ac6ySBqp7qulWDXQ&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUSHY>(&mut v2, 5000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUSHY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUSHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

