module 0xf0f521f480f7602cb259e1c353188465c75b344171f6b1a1df197c236d7b06e8::BUBBLES {
    struct BUBBLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLES>(arg0, 2, b"Bubbles", b"BUBE", b"In the BubbleVerse, tokens represent fragile, shimmering bubbles. Each bubble holds value, but can burst at any moment, releasing its value to the community., Website: TBA after launch, TG: https://t.me/+g00t9z-QWDBjMzY0, X: https://x.com/bubbles_sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/WbLzRFjk/Bubbles-on-sui.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUBBLES>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUBBLES>(&mut v2, 100000000000, @0x2f8e7820a2712d605de34084e68ca82d8d8f34de7c340de5345b1842c561f7c2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLES>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

