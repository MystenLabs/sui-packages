module 0x2db4a2d7cef06ee7de4fd9a60b426010f933ba4ba899c5faf6afdb585f00b2e5::mickey {
    struct MICKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MICKEY>(arg0, 9, b"MICKEY", b"Mickey", b"Sui Mickey To The Moon Sui Community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1849106974207598592/ftu4plPc_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MICKEY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICKEY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MICKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

