module 0x6add5b23a75ed78c7230a9aef71c516be7e21b7aa38a33702aee81602b595ef3::bluedoge {
    struct BLUEDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEDOGE>(arg0, 9, b"BLUEDOGE", b"Blue Doge", b"Blue Doge Is Meme On Sui Chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844804724446646272/Jo2vUjgB.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUEDOGE>(&mut v2, 447000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEDOGE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

