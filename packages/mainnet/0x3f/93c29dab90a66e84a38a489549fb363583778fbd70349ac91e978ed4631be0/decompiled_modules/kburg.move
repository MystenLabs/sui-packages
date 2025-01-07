module 0x3f93c29dab90a66e84a38a489549fb363583778fbd70349ac91e978ed4631be0::kburg {
    struct KBURG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KBURG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KBURG>(arg0, 6, b"KBURG", b"Kangreburguer", b"Introducing Kangreburger, the cryptocurrency that's beefing up the blockchain! This juicy token is packed with flavor and ready to grill the competition. Don't get left in the bun, join the Kangreburger revolution and sink your teeth into the future of finance. It's a patty-fect storm of profits and laughter, so don't be a chicken - invest in Kangreburger today and let the good times roll!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_e24c07b1a0.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KBURG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KBURG>>(v1);
    }

    // decompiled from Move bytecode v6
}

