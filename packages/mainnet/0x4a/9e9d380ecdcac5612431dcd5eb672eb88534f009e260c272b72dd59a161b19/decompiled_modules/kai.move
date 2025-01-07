module 0x4a9e9d380ecdcac5612431dcd5eb672eb88534f009e260c272b72dd59a161b19::kai {
    struct KAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAI>(arg0, 6, b"Kai", b"KAI", b"Kai the normies turtle, but get bully coz dickhead", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241009_005226_386_d0a2bddd62.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

