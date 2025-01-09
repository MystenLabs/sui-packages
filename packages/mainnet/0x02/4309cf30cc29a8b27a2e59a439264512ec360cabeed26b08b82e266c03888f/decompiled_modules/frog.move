module 0x24309cf30cc29a8b27a2e59a439264512ec360cabeed26b08b82e266c03888f::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROG>(arg0, 9, b"frg", b"frog", b"frog kicked the toddler", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTqN0Hsy4Epj6DrXa8RLuQZIZpBIjK8HNUKmA&s")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FROG>>(0x2::coin::mint<FROG>(&mut v2, 998668574000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FROG>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

