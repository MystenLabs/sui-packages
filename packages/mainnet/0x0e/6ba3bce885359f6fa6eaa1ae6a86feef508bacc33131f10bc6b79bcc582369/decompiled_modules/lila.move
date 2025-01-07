module 0xe6ba3bce885359f6fa6eaa1ae6a86feef508bacc33131f10bc6b79bcc582369::lila {
    struct LILA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LILA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LILA>(arg0, 6, b"LILA", b"LI LA is the new future", b"LIla on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://hotpot.ai/images/site/ai/photoshoot/avatar/style_gallery/38.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LILA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LILA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LILA>>(v1);
    }

    // decompiled from Move bytecode v6
}

