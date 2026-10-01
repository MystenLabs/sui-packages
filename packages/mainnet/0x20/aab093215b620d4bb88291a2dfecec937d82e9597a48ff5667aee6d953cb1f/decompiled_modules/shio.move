module 0x20aab093215b620d4bb88291a2dfecec937d82e9597a48ff5667aee6d953cb1f::shio {
    struct SHIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SHIO>(arg0, 6, 0x1::string::utf8(b"SHIO"), 0x1::string::utf8(b"Shio"), 0x1::string::utf8(b"Redistribute the value back to sui community"), 0x1::string::utf8(b"https://popularsui.xyz/media/c0b81538403f754e2cbaa5fc3f358951999c4f1f7e56ed150c9acab2e5dd4e82.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SHIO>>(0x2::coin_registry::finalize<SHIO>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

