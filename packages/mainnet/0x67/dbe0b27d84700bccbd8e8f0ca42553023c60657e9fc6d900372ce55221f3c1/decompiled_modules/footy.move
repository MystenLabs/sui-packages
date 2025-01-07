module 0x67dbe0b27d84700bccbd8e8f0ca42553023c60657e9fc6d900372ce55221f3c1::footy {
    struct FOOTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOOTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOOTY>(arg0, 6, b"FOOTY", b"Footy on top make money", b"Footy on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://hotpot.ai/images/site/ai/photoshoot/avatar/style_gallery/38.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FOOTY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOOTY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOOTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

