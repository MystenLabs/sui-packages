module 0xd8b46a13a85cb67e4b8b60aa94007268c458c9787074efc7818bbf642a919748::speng {
    struct SPENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPENG>(arg0, 6, b"SPENG", b"SUI PENG", b"Meet SUI PENG, the smartest and cutest penguin-inspired memecoin powered by AI on the Sui Network! Combining the charm of penguins with the brilliance of artificial intelligence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1736007208144_aa5cec1748.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

