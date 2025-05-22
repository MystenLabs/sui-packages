module 0xe13dfe0a425777614b76e988deaa673a5840e8fe0f5c6a60937b4d7524567ee8::bbcat {
    struct BBCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBCAT>(arg0, 9, b"BBCAT", b"Bubble cat", b"TEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.slaunch.xyz/staging/tokens/41d8dc73-2292-457a-ba66-ea917b29dbff.webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BBCAT>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBCAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

