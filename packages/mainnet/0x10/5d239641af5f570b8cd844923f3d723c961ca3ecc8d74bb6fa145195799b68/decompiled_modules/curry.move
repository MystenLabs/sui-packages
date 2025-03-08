module 0x105d239641af5f570b8cd844923f3d723c961ca3ecc8d74bb6fa145195799b68::curry {
    struct CURRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CURRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CURRY>(arg0, 9, b"CURRY", b"Curry", b"A spicy token for all your culinary needs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CURRY>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CURRY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CURRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

