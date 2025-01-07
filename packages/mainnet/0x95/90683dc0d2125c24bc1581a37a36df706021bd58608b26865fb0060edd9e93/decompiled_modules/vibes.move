module 0x9590683dc0d2125c24bc1581a37a36df706021bd58608b26865fb0060edd9e93::vibes {
    struct VIBES has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIBES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIBES>(arg0, 9, b"VIBES", b"SummerVibe", b"Summer Vibes are back", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VIBES>(&mut v2, 2200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIBES>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIBES>>(v1);
    }

    // decompiled from Move bytecode v6
}

