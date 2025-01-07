module 0xb10dd3c4da42206d3a9fe0f3560830844e9c6bc507478dc5b15b7ff67e02b6dc::tb {
    struct TB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TB>(arg0, 9, b"Tiger Boy", b"TB", b"Fucking kill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://static.vecteezy.com/system/resources/previews/033/494/443/non_2x/cute-chibi-boy-wearing-a-tiger-hoodie-ai-generative-png.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TB>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TB>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TB>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

