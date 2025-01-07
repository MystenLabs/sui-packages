module 0x3907e9d4a63ba1ad25229360c32920d725bc805bde51009350ebdfdd09a96779::based {
    struct BASED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASED>(arg0, 9, b"BASED", b"Make America Based Again", b"Time for America to be based again - join the movement with Elon Musk's Make America Based Again !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1842989833431531521/lHxg7u6R_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BASED>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BASED>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BASED>>(v1);
    }

    // decompiled from Move bytecode v6
}

