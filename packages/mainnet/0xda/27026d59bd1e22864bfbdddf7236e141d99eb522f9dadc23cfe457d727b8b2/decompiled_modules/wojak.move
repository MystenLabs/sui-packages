module 0xda27026d59bd1e22864bfbdddf7236e141d99eb522f9dadc23cfe457d727b8b2::wojak {
    struct WOJAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOJAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOJAK>(arg0, 9, b"WOJAK", b"Wojak", b"Wojak is a meme character symbolizing emotions like sadness and frustration. Known as \"Feels Guy,\" he represents relatable feelings with different versions like \"Doomer\" (hopeless) and \"Chad\" (confident), widely used in online culture.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844212240955691019/tV8u68QA.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WOJAK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOJAK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOJAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

