module 0xd90a5e9f56a62009ac51e740b1be6d00eb9928f4c24627096923df5fde2306ed::huhcat {
    struct HUHCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUHCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUHCAT>(arg0, 9, b"HUHCAT", b"HUHCAT", b"HuhCat - The Cutest Meme Cat Token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/6WtU2To.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HUHCAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUHCAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUHCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

