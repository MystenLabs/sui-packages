module 0x53c71f75236e525ce05873ea4b5e985b1db0edfef24847cda152b4aa9fedf9c7::gyu {
    struct GYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GYU>(arg0, 9, b"GYU", b"GYU", b"GGGUUUIII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.app.goo.gl/esu4bs4dL8BsBkmn7")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GYU>(&mut v2, 435545345000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GYU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GYU>>(v1);
    }

    // decompiled from Move bytecode v6
}

