module 0xcfa3d8ecd5f6ebe3cd353eb4ea42e858f700ee3b7dc31c999d75874047f3c0ff::lauren {
    struct LAUREN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAUREN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAUREN>(arg0, 9, b"LAUREN", b"Lauren Phillips", b"Lauren Phillips is the original cute mascot of the Sui blockchain ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ih1.redbubble.net/image.5327118225.9721/bg,f8f8f8-flat,750x,075,f-pad,750x1000,f8f8f8.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LAUREN>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAUREN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAUREN>>(v1);
    }

    // decompiled from Move bytecode v6
}

