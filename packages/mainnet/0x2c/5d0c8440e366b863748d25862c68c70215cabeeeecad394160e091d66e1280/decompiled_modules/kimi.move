module 0x2c5d0c8440e366b863748d25862c68c70215cabeeeecad394160e091d66e1280::kimi {
    struct KIMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIMI>(arg0, 9, b"KIMI", b"KIMI", b"From 0 to 10 million!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ordinarydecentgamer.com/wp-content/uploads/2011/08/jackie-chan-meme-200x200.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KIMI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIMI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

