module 0xd565c081418196ff5ecb20591b392dbb53f38fed877d8eb90425b2f7942699e6::vibe {
    struct VIBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIBE>(arg0, 9, b"VIBE", b"VIBE", b"VIBE OF DAY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://wallpapers.com/images/hd/vibe-background-5exrqa0ly2v48rer.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VIBE>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIBE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

