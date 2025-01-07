module 0x15a1fcd4e2fd5b27d5334dbd184bee8a26b92d907ae92c4f1bb3d5c283e9c546::suipeng {
    struct SUIPENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPENG>(arg0, 6, b"SUIPENG", b"SuiPeng", x"48492c20494d202453554950454e47210a0a50454f504c452054454c4c204d452049204c4f4f4b204c494b4520504550452e0a492054454c4c205448454d20494d20412050454e4755494e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039151_18be5dc1ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

