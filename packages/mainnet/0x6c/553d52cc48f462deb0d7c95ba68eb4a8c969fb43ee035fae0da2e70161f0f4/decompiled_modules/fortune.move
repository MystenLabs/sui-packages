module 0x6c553d52cc48f462deb0d7c95ba68eb4a8c969fb43ee035fae0da2e70161f0f4::fortune {
    struct FORTUNE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORTUNE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORTUNE>(arg0, 9, b"FORTUNE", b"Good Fortune", b"Is dedicated to the celebration of Lunar New Year.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dribbble.com/userupload/13005691/file/original-deab785f9a0f0e24c9556423a46452fb.jpg?resize=1024x768")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FORTUNE>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORTUNE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FORTUNE>>(v1);
    }

    // decompiled from Move bytecode v6
}

