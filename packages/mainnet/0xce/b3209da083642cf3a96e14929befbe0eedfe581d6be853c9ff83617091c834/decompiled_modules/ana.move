module 0xceb3209da083642cf3a96e14929befbe0eedfe581d6be853c9ff83617091c834::ana {
    struct ANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANA>(arg0, 6, b"ANA", b"Ana AI", b"$ANA - Your AI Internet girlfriend.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2220_ae173f1796.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

