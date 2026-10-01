module 0x3892d333c4153227a15d9d2c04de044af4aa722c1cfb42c1e6e0ba66bb546045::us {
    struct US has drop {
        dummy_field: bool,
    }

    fun init(arg0: US, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<US>(arg0, 9, 0x1::string::utf8(b"US"), 0x1::string::utf8(b"Talus"), 0x1::string::utf8(b"The native token for the Talus Network."), 0x1::string::utf8(b"https://strapi-space-bucket-fra1-1.fra1.cdn.digitaloceanspaces.com/Talus_logo_cbd2bc13e7.png"), arg1);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<US>>(0x2::coin::mint<US>(&mut v2, 2910000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<US>>(v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<US>>(0x2::coin_registry::finalize<US>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

