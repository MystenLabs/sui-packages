module 0x2254666524bb404bafc8c4b564ebd7c919d692c57398dee7eb009a6d4c7c421a::shuit {
    struct SHUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUIT>(arg0, 9, b"SHUIT", b"SHUIT", b"Welcome to SHUITEST MEME on the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1848986259818946560/KrqHFgKj_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHUIT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUIT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

