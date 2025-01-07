module 0x11fefd41480628d50128d1272c8117695f6d942b80546436f6116dfaad289aa9::spicycat {
    struct SPICYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPICYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPICYCAT>(arg0, 9, b"Spicycat", b"Spicycat", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SPICYCAT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPICYCAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPICYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

