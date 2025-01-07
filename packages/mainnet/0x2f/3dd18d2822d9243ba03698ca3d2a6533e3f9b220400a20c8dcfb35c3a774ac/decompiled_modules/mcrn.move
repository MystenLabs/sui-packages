module 0x2f3dd18d2822d9243ba03698ca3d2a6533e3f9b220400a20c8dcfb35c3a774ac::mcrn {
    struct MCRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCRN>(arg0, 9, b"MCRN", b"Macaron", b"Sui Macaron Let's go Eat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1774722191286022144/TH3-VXot_400x400.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MCRN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCRN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCRN>>(v1);
    }

    // decompiled from Move bytecode v6
}

