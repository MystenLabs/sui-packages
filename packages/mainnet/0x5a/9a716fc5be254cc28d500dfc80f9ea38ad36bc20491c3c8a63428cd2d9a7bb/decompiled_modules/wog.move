module 0x5a9a716fc5be254cc28d500dfc80f9ea38ad36bc20491c3c8a63428cd2d9a7bb::wog {
    struct WOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOG>(arg0, 6, b"WOG", b"WOG The Frog", b"Wog are tiny frogs that do things differently from other frogs. Wog shows that it's okay to be different and be yourself", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logoo_9023fbea38.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

