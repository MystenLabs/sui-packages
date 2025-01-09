module 0xed5de892bfb59f9982d38c2452b03196d7aa8bea64227e98903b405c8e4a1336::burn {
    struct BURN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BURN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BURN>(arg0, 6, b"BURN", b"Burnbro AI", b"Artificial Intelligence shitposting and roasting on X. Mention or reply to Burnbro to get roasted.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2766_4580dd1139.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BURN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BURN>>(v1);
    }

    // decompiled from Move bytecode v6
}

