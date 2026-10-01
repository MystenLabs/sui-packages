module 0x689b8ced6d9997a6e61791cbd7ab9abb23da455a9719c9539da44984eb6d7320::mario {
    struct MARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MARIO>(arg0, 6, 0x1::string::utf8(b"MARIO"), 0x1::string::utf8(b"Mario"), 0x1::string::utf8(b"trial dont buy https://t.co/eG1y6xz4nA"), 0x1::string::utf8(b"https://pbs.twimg.com/media/HTj6OhvboAAvp7T.jpg"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MARIO>>(0x2::coin_registry::finalize<MARIO>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

