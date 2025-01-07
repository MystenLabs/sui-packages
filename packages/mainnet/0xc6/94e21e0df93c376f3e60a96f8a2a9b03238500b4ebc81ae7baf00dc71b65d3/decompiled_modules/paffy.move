module 0xc694e21e0df93c376f3e60a96f8a2a9b03238500b4ebc81ae7baf00dc71b65d3::paffy {
    struct PAFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAFFY>(arg0, 9, b"PAFFY", b"PAFFY", b"PAFFY party is about to start, hop in and let's get wild!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1262614985504550913/_yOCL7XC.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PAFFY>(&mut v2, 900000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAFFY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

