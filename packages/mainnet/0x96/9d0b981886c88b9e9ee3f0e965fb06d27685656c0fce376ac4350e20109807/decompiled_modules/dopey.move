module 0x969d0b981886c88b9e9ee3f0e965fb06d27685656c0fce376ac4350e20109807::dopey {
    struct DOPEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPEY>(arg0, 9, b"DOPEY", b"DOPEY", b"Just a dope meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/466032435306573825/cj83X4sx.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOPEY>(&mut v2, 13370000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPEY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOPEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

