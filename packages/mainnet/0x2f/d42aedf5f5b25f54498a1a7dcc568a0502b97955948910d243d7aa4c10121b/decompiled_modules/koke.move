module 0x2fd42aedf5f5b25f54498a1a7dcc568a0502b97955948910d243d7aa4c10121b::koke {
    struct KOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOKE>(arg0, 6, b"KOKE", b"SuiKoke", b"$KOKE IS THE CUTEST ANIMAL ON SUI, ON A MISSION TO BE THE GREATEST DOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001318_f0975a6ba9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

